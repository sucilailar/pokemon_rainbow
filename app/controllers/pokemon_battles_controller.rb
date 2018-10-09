class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [ :surrender, :attack, :show, :edit, :update, :destroy]

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

    @pokemon_battle_log = PokemonBattleLog.new
    @pokemon_battle_logs = PokemonBattleLog.where(pokemon_battle_id: @pokemon_battle.id)
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
    @action_params = params[:action]
    @battle_encaps = BattleEngine.new(attacker, defender, skill, @pokemon_battle, @action_params)
    if @battle_encaps.valid_next_turn?
      @battle_encaps.next_turn!
    else
      flash[:notice] = "Invalid Next Turn"
    end

    if @pokemon_battle.pokemon_winner_id.present?
      flash[:notice] = "#{@pokemon_battle.pokemon_winner.name} WIN, #{@pokemon_battle.pokemon_loser.name} LOSE"
    end
    #     require 'pry'
    # binding.pry
    # ?@battle_log = PokemonBattleLog.new(attacker, defender, skill, @action_params, @pokemon_battle)
    redirect_to pokemon_battle_url(@pokemon_battle)
  end

  def surrender
    @action_params = params[:action]
    attacker = Pokemon.find(pokemon_attack_params[:attacker])
    defender = Pokemon.find(pokemon_attack_params[:defender])
    skill = Skill.find(pokemon_attack_params[:skill_id])
    @battle_encaps = BattleEngine.new(attacker, defender, skill, @pokemon_battle, @action_params)
    if @battle_encaps.valid_next_turn?
      @battle_encaps.next_turn!
    else
      flash[:notice] = "Invalid Next Turn"
    end
    if @pokemon_battle.pokemon_winner_id.present?
      flash[:notice] = "#{@pokemon_battle.pokemon_winner.name} WIN, #{@pokemon_battle.pokemon_loser.name} LOSE"
    end
    redirect_to pokemon_battle_url(@pokemon_battle)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle
      @pokemon_battle = PokemonBattle.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id, :current_turn, :state, :pokemon_winner_id, :pokemon_loser_id, :experience_gain, :pokemon1_max_health_point, :pokemon2_max_health_point)
    end

    def pokemon_attack_params
      params.require(:pokemon_battle).permit(:attacker, :defender, :skill_id)
    end
  end