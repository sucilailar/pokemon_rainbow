require 'test_helper'

class PokemonTest < ActiveSupport::TestCase

	def setup
		@pokedex = Pokedex.new(name: "Example Pokedex", base_health_point: 34, base_attack: 30, 
      	base_defence: 30, base_speed: 30, element_type: "fire",
      	image_url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")
    	@pokedex.save

		@pokemon = Pokemon.new(name: "Example Pokemon", current_health_point: 30, 
			current_experience: 30, pokedex_id: @pokedex.id, 
			max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
		@pokemon.save
	end

	test "pokedex should be have relation with pokemon " do
		assert_equal "Example Pokedex", @pokemon.pokedex.name
	end

	test "should be valid" do
		assert @pokemon.valid?
	end

	test "name should be present" do
		@pokemon.name = " "
		assert_not @pokemon.valid?
	end

	test "name should be uniq" do
	end

	test "current health point should be present" do
		@pokemon.current_health_point = " "
		assert_not @pokemon.valid?
	end

	test "current experience should be present" do
		@pokemon.current_experience = " "
		assert_not @pokemon.valid?
	end

	# test "max health point should be present" do
	# 	@pokemon.max_health_point = " "
	# 	assert_not @pokemon.valid?
	# end

	test "attack should be present" do
		@pokemon.attack = " "
		assert_not @pokemon.valid?
	end

	test "defence should be present" do
		@pokemon.defence = " "
		assert_not @pokemon.valid?
	end

	test "level should be present" do
		@pokemon.level = " "
		assert_not @pokemon.valid?
	end

	test "current health point must less or than equal to max health point" do
		@pokemon.current_health_point = 35
		assert_not @pokemon.valid?
	end

	test "current health point greater than or equal to 0" do
		assert_operator @pokemon.current_health_point, :>=, 0
	end

	test "current_experience greater than or equal to" do
		assert_operator @pokemon.current_experience, :>=, 0
	end

	test "current max health point greater than 0" do
		assert_operator @pokemon.max_health_point, :>, 0
	end

	test "attack greater than 0" do
		assert_operator @pokemon.attack, :>, 0
	end

	test "defence greater than 0" do
		assert_operator @pokemon.defence, :>, 0
	end

	test "speed greater than 0" do
		assert_operator @pokemon.speed, :>, 0
	end
		test "level greater than 0" do
		assert_operator @pokemon.level, :>, 0
	end

end