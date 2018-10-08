require 'test_helper'

class BattleEngineTest < ActiveSupport::TestCase

	def setup
		@pokedex = Pokedex.new(name: "Example Pokedex", base_health_point: 34, base_attack: 30, 
      	base_defence: 30, base_speed: 30, element_type: "fire",
      	image_url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")
    @pokedex.save

		@pokemon = Pokemon.new(name: "Example Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon.save

		@pokemon2 = Pokemon.new(name: "Pokemon Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon2.save

		@skill = Skill.new(name: "Example Skill", power: 30, max_pp: 30,
			element_type: "water")
		@skill.save
		# @pokemon_skill.save

		p1 = Pokemon.find_by(name: "Example Pokemon")
		s1 = Skill.find_by(name: "Example Skill")
		@pokemon_skill = PokemonSkill.new(pokemon: p1, skill: s1, current_pp: 40)
		@pokemon_skill.save



		@pokemon_battle = PokemonBattle.new(pokemon1_id: @pokemon.id, pokemon2_id: @pokemon2.id,
			current_turn: 3, state: "ongoing", pokemon_winner_id: @pokemon2.id, pokemon_loser_id: @pokemon.id,
			experience_gain: 40, pokemon1_max_health_point: 20, pokemon2_max_health_point: 10)
		@pokemon_battle.save

		@battle_engine = BattleEngine.new(@pokemon, @pokemon2,
		@pokemon_skill, @pokemon_battle, "attack")

	end
	
	test "valid turn battle engine " do
		assert @battle_engine.valid_next_turn?
	end


	test "invalid turn for battle" do
		@pokemon_battle.current_turn = 2
		@pokemon_battle.save
		@battle_engine = BattleEngine.new(@pokemon, @pokemon2,
		@pokemon_skill, @pokemon_battle, "attack")
		assert_not @battle_engine.valid_next_turn?
	end

	test "attack when not its turn" do
		@pokemon_battle.current_turn = 3
		@pokemon_battle.save
		@battle_engine = BattleEngine.new(@pokemon2, @pokemon1,
		@pokemon_skill, @pokemon_battle, "attack")
		assert_not @battle_engine.valid_next_turn?
	end

	test "surrender when not its turn" do
		@pokemon_battle.current_turn = 3
		@pokemon_battle.save
		@battle_engine = BattleEngine.new(@pokemon2, @pokemon1,
		@pokemon_skill, @pokemon_battle, "surrender")
		assert_not @battle_engine.valid_next_turn?
	end

end