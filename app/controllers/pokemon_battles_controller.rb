class PokemonBattlesController < ApplicationController
  before_action :set_pokemon_battle, only: [:attack, :show, :edit, :update, :destroy]

  # GET /pokemon_battles
  # GET /pokemon_battles.json
  def index

   per_page = 5
    if params[:page].present?
      params[:page] = params[:page].to_i
    else
      params[:page] = 1
    end
    @pokemon_battles = PokemonBattle.paginate(:page => params[:page], :per_page => per_page)
    @row_number = ((params[:page] - 1) * per_page) + 1
  end

  # GET /pokemon_battles/1
  # GET /pokemon_battles/1.json
  def show
    @pokemon1 = Pokemon.find(@pokemon_battle.pokemon1_id)
    @pokemon2 = Pokemon.find(@pokemon_battle.pokemon2_id)

    @pokedex = Pokemon.find(@pokemon_battle.pokemon2_id).pokedex
    @pokedex2 = Pokemon.find(@pokemon_battle.pokemon1_id).pokedex
    # @pokemon_attack = Skill.find(@skill.pokemon_id)

    @pokemon_name = @pokemon1.name
    @pokemon_name2 = @pokemon2.name

    @pokemon_attack_number = @pokemon1.attack
    @pokemon_attack_number2 = @pokemon2.attack

    @skill_select1 = PokemonSkill.where("pokemon_id = ? AND current_pp > ?", @pokemon1.id, 0).map{|pokemon_skill|
      ["#{pokemon_skill.skill.name} (#{pokemon_skill.current_pp}/#{pokemon_skill.skill.max_pp})", pokemon_skill.skill.id]
    }
    @skill_select2 = PokemonSkill.where(pokemon_id: @pokemon2.id).map{|pokemon_skill|
        ["#{pokemon_skill.skill.name} (#{pokemon_skill.current_pp}/#{pokemon_skill.skill.max_pp})", pokemon_skill.skill.id]
    }



    # require 'pry'
    # binding.pry

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
    # require 'pry'
    # binding.pry
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
   # require 'pry'
   #  binding.pry
    attacker = Pokemon.find(pokemon_attack_params[:attacker])
    defender = Pokemon.find(pokemon_attack_params[:defender])
    skill = Skill.find(pokemon_attack_params[:skill_id])
    @pokemon_skill = PokemonSkill.find_by(pokemon_id: attacker.id, skill_id: skill.id)
    damage = PokemonBattleCalculator.calculate_damage(attacker, defender, skill)
   
    defender_hp = defender.current_health_point

    if defender_hp < damage
         defender.current_health_point = 0
    else
          min_hp = defender_hp - damage
          defender.current_health_point = min_hp
    end

    @pokemon_skill.current_pp -= 1
    @pokemon_battle.current_turn += 1

    defender.save
    @pokemon_skill.save
    @pokemon_battle.save

    redirect_to pokemon_battle_url(@pokemon_battle)

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_battle
      @pokemon_battle = PokemonBattle.find(params[:id])
    end

    #  def set_pokemon_battle_params
    #   @pokedex = Pokemon.find(params[:id])
    # end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_battle_params
      params.require(:pokemon_battle).permit(:pokemon1_id, :pokemon2_id, :current_turn, :state, :pokemon_winner_id, :pokemon_loser_id, :experience_gain, :pokemon1_max_health_point, :pokemon_2_max_health_point)
    end

    def pokemon_attack_params
      params.require(:pokemon_battle).permit(:attacker, :defender, :skill_id)
    end
  end
