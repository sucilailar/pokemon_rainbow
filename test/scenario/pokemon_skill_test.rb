require 'test_helper'

class SkillTest < ActiveSupport::TestCase

	def setup 
		@pokedex = Pokedex.new(name: "Example Pokedex", base_health_point: 34, base_attack: 30, 
      	base_defence: 30, base_speed: 30, element_type: "fire",
     	image_url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")
    	@pokedex.save
		@skill = Skill.new(name: "Example Skill", power: 30, max_pp: 30,
			element_type: "water")
		@skill.save
		@pokemon = Pokemon.new(name: "Example Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon.save

		@pokemon_skill = PokemonSkill.new(skill_id: @skill.id , pokemon_id: @pokemon.id, current_pp: 8)	
	end

	test "pokemon skill should be valid" do

		@pokemon_skill.valid?
	end

	test "pokemon skill should have relation with skill" do
		assert_equal "Example Skill", @pokemon_skill.skill.name
	end

	test "current pp should be greater than or equal to 0" do
		assert_operator @pokemon_skill.current_pp, :>=, 0
	end

	test "current pp should be less than max_pp" do
		assert_operator @pokemon_skill.current_pp, :<=, @pokemon_skill.pokemon.current_health_point
	end




end