require 'test_helper'

class PokedexTest < ActiveSupport::TestCase

	def setup
		@pokedex = Pokedex.new(name: "Example Pokedex", base_health_point: 34, base_attack: 30, 
      base_defence: 30, base_speed: 30, element_type: "fire",
      image_url: "http://assets.pokemon.com/assets/cms2/img/pokedex/full/001.png")
    @pokedex.save

    @pokemon = Pokemon.new(name: "Example Pokemo", current_health_point: 30, 
      current_experience: 30, pokedex_id: @pokedex.id, 
      max_health_point: 30, attack:30, defence:30, level: 1, speed: 30)
    @pokemon.save

	end

	test 'name should be present' do
		pokedex = Pokedex.new(name: " ")
		assert_not pokedex.valid?, "pokedex name is empty string"
		puts "name is present"
  	end

  	test 'base health point should be present' do
  		pokedex = Pokedex.new(base_health_point: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base health point is empty"
		puts "base health point is present"
	end

  	test 'base attack should be present' do
  		pokedex = Pokedex.new(base_attack: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base attack is empty"
		puts "base attack is present"
  	end

  	test 'base defence should be present' do
  		pokedex = Pokedex.new(base_defence: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base defence is empty"
		puts "base defence is present"
  	end

  	test 'base speed should be present' do
  		pokedex = Pokedex.new(base_speed: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base speed is empty"
		puts "base speed is present"
  	end

  	test "name should be unique" do
  		duplicate_pokedex = @pokedex.dup
      duplicate_pokedex.name = @pokedex.name
  		@pokedex.save
  		assert_not duplicate_pokedex.valid?
      puts "name unique"
  	end

    test "name should not too long" do
      @pokedex.name = "a" * 50
      assert_not @pokedex.valid?
    end

    test "element type should not too long" do
      @pokedex.element_type = "a" * 50
      assert_not @pokedex.valid?
    end

    test "image url should not too long" do
      @pokedex.image_url = "a" * 266
      assert_not @pokedex.valid?
    end

    test "base health point greater than 0" do
      @pokedex.base_health_point = -1
      assert_not @pokedex.valid?
    end

    test "base attack should greater than 0" do
      @pokedex.base_attack = -1
      assert_not @pokedex.valid?
    end

    test "base defence should greater than 0" do
      @pokedex.base_defence = -1
      assert_not @pokedex.valid?
    end

    test "base speed should greater than 0" do
      @pokedex.base_speed = -1
      assert_not @pokedex.valid?
    end

    test "element type must inclusion" do
      @pokedex.element_type = "api"
      assert_not @pokedex.valid?
    end
end
