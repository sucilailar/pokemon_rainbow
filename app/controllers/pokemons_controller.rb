class PokemonsController < ApplicationController


  before_action :set_pokemon, only: [:show, :edit, :update, :destroy]

  # GET /pokemons
  # GET /pokemons.json
  def index
    per_page = 5
    if params[:page].present?
      params[:page] = params[:page].to_i
    else
      params[:page] = 1
    end
    @pokemons = Pokemon.paginate(:page => params[:page], :per_page => per_page)
    @row_number = ((params[:page] - 1) * per_page) + 1
  end

  # GET /pokemons/1
  # GET /pokemons/1.json
  def show
    @pokedex = Pokemon.find(@pokemon[:id]).pokedex
    element_type = @pokedex.element_type
    @skill_select = Skill.where(element_type: element_type).map{|x| [x.name, x.id]}
    @pokemon_skills = PokemonSkill.where(pokemon_id: @pokemon.id)
    @pokemon_skill = PokemonSkill.new
  end

  # GET /pokemons/new
  def new
    @pokemon = Pokemon.new()
  end

  # GET /pokemons/1/edit
  def edit
     # require 'pry'
    # binding.pry
    @pokedex = Pokemon.find(@pokemon[:id]).pokedex
    element_type = @pokedex.element_type
    @skill_select = Skill.where(element_type: element_type).map{|x| [x.name, x.id]}
    @pokemon_skills = PokemonSkill.where(pokemon_id: @pokemon.id)
    @pokemon_skill = PokemonSkill.new

  end

  # POST /pokemons
  # POST /pokemons.json
  def create
    @pokemon = Pokemon.new(pokemon_params)
    # require 'pry'
    # binding.pry
    @pokedex = Pokedex.find(@pokemon.pokedex_id)
    @pokemon.max_health_point = @pokedex.base_health_point
    @pokemon.current_health_point = @pokedex.base_health_point
    @pokemon.attack = @pokedex.base_attack
    @pokemon.defence = @pokedex.base_defence
    @pokemon.speed = @pokedex.base_speed
    @pokemon.current_experience = 0
    @pokemon.level = 1

      if @pokemon.save
        redirect_to @pokemon, notice: 'Pokemon was successfully created.'
      else
        render :new
      end
  end

  # PATCH/PUT /pokemons/1
  # PATCH/PUT /pokemons/1.json
  def update

    
       # require 'pry'
       # binding.pry
      if @pokemon.update(pokemon_params_edit)
        redirect_to @pokemon, notice: 'Pokemon was successfully updated.'
      else
        render :edit, notice: 'Failed to Edit!'
      end
  end

  # DELETE /pokemons/1
  # DELETE /pokemons/1.json
  def destroy
    @pokemon.destroy
      redirect_to pokemons_url, notice: 'Pokemon was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon
      @pokemon = Pokemon.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_params
      params.require(:pokemon).permit(:pokedex_id, :name, :element_type)
    end

    def pokemon_params_edit
      params.require(:pokemon).permit(:pokedex_id, :name, :element_type, :max_health_point, :current_health_point, :attack, :defence, :speed, :current_experience)
    end

end
