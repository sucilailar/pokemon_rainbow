class PokemonSkillsController < ApplicationController
  before_action :set_pokemon_skill, only: [:show, :edit, :update, :destroy]

  def create
    @pokemon_skill = PokemonSkill.new(pokemon_skill_params)
    @pokemon_skill.pokemon_id = params[:pokemon_id]
    skill = Skill.find(@pokemon_skill.skill_id)
    @pokemon_skill.current_pp = skill.max_pp

    
      if @pokemon_skill.save
        redirect_to pokemon_url(@pokemon_skill.pokemon), notice: 'Pokemon skill was successfully created.'
      else
        redirect_to pokemon_url(@pokemon_skill.pokemon), notice: 'Duplicate skill.'
      end
  end

  # PATCH/PUT /pokemon_skills/1
  # PATCH/PUT /pokemon_skills/1.json

  # DELETE /pokemon_skills/1
  # DELETE /pokemon_skills/1.json

  
  def destroy
    @pokemon_skill.destroy
      redirect_to pokemon_url(@pokemon_skill.pokemon), notice: 'Pokemon skill was successfully destroyed.' 
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pokemon_skill
      @pokemon_skill = PokemonSkill.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pokemon_skill_params
      params.require(:pokemon_skill).permit(:skill_id)
    end

    def pokemon_params
      params.require(:pokemon).permit(:pokedex_id, :name, :element_type)
    end
    
end
