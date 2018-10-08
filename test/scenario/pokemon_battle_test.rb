require 'test_helper'

class PokemonBattleTest < ActiveSupport::TestCase

	def setup
		@pokedex = Pokedex.new(name: "Example Pokedex", base_health_point: 34, base_attack: 30, 
      	base_defence: 30, base_speed: 30, element_type: "fire",
      	image_url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")
    	@pokedex.save

		@pokemon = Pokemon.new(name: "Example Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon2 = Pokemon.new(name: "Pokemon Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon.save
		@pokemon2.save

		@skill = Skill.new(name: "Example Skill", power: 30, max_pp: 30,
			element_type: "water")

		@pokemon_battle = PokemonBattle.new(pokemon1_id: @pokemon.id, pokemon2_id: @pokemon2.id,
			current_turn: 2, state: "ongoing", pokemon_winner_id: @pokemon2.id, pokemon_loser_id: @pokemon.id,
			experience_gain: 40, pokemon1_max_health_point: 20, pokemon2_max_health_point: 10)

	end

	test "pokemon battle valid" do
		# assert @pokedex.valid?
		# assert @pokemon.valid?
		# assert @pokemon2.valid?
		assert @pokemon_battle.valid?
	end

	test "pokemon1 belongs to Pokemon" do
		assert_equal "Example Pokemon", @pokemon_battle.pokemon1.name
	end

	test "pokemon2 belongs to Pokemon" do
		assert_equal "Pokemon Pokemon", @pokemon_battle.pokemon2.name
	end

	test "pokemon winner belongs to Pokemon" do
		assert_equal "Pokemon Pokemon", @pokemon_battle.pokemon2.name
	end

	test "pokemon loser belongs to Pokemon" do
		assert_equal "Example Pokemon", @pokemon_battle.pokemon1.name
	end

	test "pokemon 1 not same with pokemon 2" do 
		assert_not_equal @pokemon_battle.pokemon1_id, @pokemon_battle.pokemon2_id
	end

	test "current hp pokemon1 should be greater than 0" do
		assert_operator @pokemon_battle.pokemon1.current_health_point, :>, 0
	end

	test "current hp pokemon2 should be greater than 0" do
		assert_operator @pokemon_battle.pokemon2.current_health_point, :>, 0

	end
end