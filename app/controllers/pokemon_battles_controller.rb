class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [ :surrender, :attack, :show, :edit, :update, :destroy]
  #dijalankan pada method yg ada di dalam only, tdk dijalankan pada method except, untuk mengurangi pengulangan 
  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index
   per_page = 5
    if params[:page].present?
      params[:page] = params[:page].to_i
    else
      params[:page] = 1
    end
    @pokemon_battles = PokemonBattle.paginate(:page => params[:page], :per_page => per_page).order(created_at: :desc)
    @row_number = ((params[:page] - 1) * per_page) + 1
  end
  # GET /pokemon_battles/1
  # GET /pokemon_battles/1.json
  def show
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    @pokedex = Pokemon.find(@pokemon_battle.pokemon2_id).pokedex
    @pokedex2 = Pokemon.find(@pokemon_battle.pokemon1_id).pokedex
    @skill_select1 = PokemonSkill.where("pokemon_id = ? AND current_pp > ?", @pokemon1.id, 0).map{|pokemon_skill|
      ["#{pokemon_skill.skill.name} (#{pokemon_skill.current_pp}/#{pokemon_skill.skill.max_pp})", pokemon_skill.skill.id]
    }
    @skill_select2 = PokemonSkill.where("pokemon_id = ? AND current_pp > ?", @pokemon2.id, 0).map{|pokemon_skill|
        ["#{pokemon_skill.skill.name} (#{pokemon_skill.current_pp}/#{pokemon_skill.skill.max_pp})", pokemon_skill.skill.id]
    }
  end
  # GET /pokemon_battles/new
  def new
    @pokemon_name = Pokemon.select(:id, :name).map{|x| [x.name, x.id]}
    @pokemon_battle = PokemonBattle.new
  end

  # GET /pokemon_battles/1/edit
  def edit
  end

  # POST /pokemon_battles
  # POST /pokemon_battles.json
  def create
    @pokemon_battle = PokemonBattle.new(pokemon_battle_params)
    @pokemon = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)
    @pokemon_battle.pokemon1_max_health_point = @pokemon.current_health_point
    @pokemon_battle.pokemon2_max_health_point = @pokemon2.current_health_point
    @pokemon_battle.current_turn = 1
    @pokemon_battle.state = 'ongoing'
    if @pokemon_battle.save
        redirect_to @pokemon_battle, notice: 'READY FOR BATTLE?! ATTACK NOW!'
    else
        @pokemon_name = Pokemon.select(:id, :name).map{|x| [x.name, x.id]}
        render :new 
    end
  end
  # PATCH/PUT /pokemon_battles/1
  # PATCH/PUT /pokemon_battles/1.json
  def update
      if @pokemon_battle.update(pokemon_battle_params)
        redirect_to @pokemon_battle, notice: 'Pokemon battle was successfully updated.'
      else
        render :edit
      end
  end
  # DELETE /pokemon_battles/1
  # DELETE /pokemon_battles/1.json
  def destroy
    @pokemon_battle.destroy
      redirect_to pokemon_battles_url, notice: 'Pokemon battle was successfully destroyed.'
  end

  def attack
    attacker = Pokemon.find(pokemon_attack_params[:attacker])
    defender = Pokemon.find(pokemon_attack_params[:defender])
    skill = Skill.find(pokemon_attack_params[:skill_id])
    @pokemon_skill = PokemonSkill.find_by(pokemon_id: attacker.id, skill_id: skill.id)
    damage = PokemonBattleCalculator.calculate_damage(attacker, defender, skill) 
    if defender.current_health_point < damage
         defender.current_health_point = 0
    else
          min_hp = defender.current_health_point - damage
          defender.current_health_point = min_hp
    end
    @pokemon_battle.current_turn += 1
    @pokemon_skill.current_pp -= 1
    @pokemon_skill.save
    defender.save
    if defender.current_health_point == 0 || attacker.current_health_point == 0
      if defender.current_health_point == 0
        @pokemon_battle.pokemon_winner_id = attacker.id
        @pokemon_battle.pokemon_loser_id = defender.id
        @pokemon_battle.state = "finish"
        flash[:notice] = "#{attacker.name} WIN, #{defender.name} LOSE"
      else
        @pokemon_battle.pokemon_winner_id = defender.id
        @pokemon_battle.pokemon_loser_id = attacker.id
        @pokemon_battle.state = "finish"
        flash[:notice] = "#{defender.name} WIN, #{attacker.name} LOSE"
      end
      @pokemon_battle.save
    end
    if @pokemon_battle.pokemon_winner_id.present?
      loser = Pokemon.find(@pokemon_battle.pokemon_loser_id)
      winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)  
        enemy_level = loser.level
        experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
        winner.current_experience = winner.current_experience + experience_gain
        @pokemon_battle.experience_gain = experience_gain
        is_level_up = PokemonBattleCalculator.level_up?(winner.level, winner.current_experience)
      if is_level_up == true
         new_level = Math::log2(winner.current_experience) - 6
         status_up = PokemonBattleCalculator.calculate_level_up_extra_stats
         winner.level = new_level
         winner.current_health_point = winner.current_health_point + status_up.health
         winner.attack = winner.attack + status_up.attack
         winner.defence = winner.defence + status_up.defence
         winner.speed = winner.speed + status_up.speed  
      end
      winner.save
    end
    @pokemon_battle.save
    redirect_to pokemon_battle_url(@pokemon_battle)
  end

  def surrender
    attacker = Pokemon.find(pokemon_attack_params[:attacker])
    defender = Pokemon.find(pokemon_attack_params[:defender])
    @pokemon_battle.pokemon_winner_id = defender.id
    @pokemon_battle.pokemon_loser_id = attacker.id
    @pokemon_battle.state = "finish"
    @pokemon_battle.save
    flash[:notice] = "#{attacker.name} LOSE, #{defender.name} WIN"
    if @pokemon_battle.pokemon_winner_id.present?
      loser = Pokemon.find(@pokemon_battle.pokemon_loser_id)
      winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)  
        enemy_level = loser.level
        experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
        winner.current_experience = winner.current_experience + experience_gain
        @pokemon_battle.experience_gain = experience_gain
        is_level_up = PokemonBattleCalculator.level_up?(winner.level, winner.current_experience)
      if is_level_up == true
         new_level = Math::log2(winner.current_experience) - 5
         status_up = PokemonBattleCalculator.calculate_level_up_extra_stats
         winner.level = new_level
         winner.current_health_point = winner.current_health_point + status_up.health
         winner.attack = winner.attack + status_up.attack
         winner.defence = winner.defence + status_up.defence
         winner.speed = winner.speed + status_up.speed  
      end
      winner.save
    end
    @pokemon_battle.save
    redirect_to pokemon_battle_url(@pokemon_battle)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle
      @pokemon_battle = PokemonBattle.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id, :current_turn, :state, :pokemon_winner_id, :pokemon_loser_id, :experience_gain, :pokemon1_max_health_point, :pokemon_2_max_health_point)
    end

    def pokemon_attack_params
      params.require(:pokemon_battle).permit(:attacker, :defender, :skill_id)
    end
  end