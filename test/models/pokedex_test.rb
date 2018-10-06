require 'test_helper'

class PokedexTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
 #  	test setup
 #  		@pokedex = Pokedex.new
   	

	# end
	def setup
		@pokedex = Pokedex.new
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
  		pokedex = Pokedex.new(base_attack: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base defence is empty"
		puts "base defence is present"
  	end

  	test 'base speed should be present' do
  		pokedex = Pokedex.new(base_speed: " ".to_i)
  		assert_not pokedex.valid?, "pokedex base speed is empty"
		puts "base speed is present"
  	end

  	test "name_should_be_uniq" do
  		@pokedex.name = "bulbasaur"
  		@pokedex.valid?
  		assert_includes(@pokedex.errors[:name], "has already been taken")
  	end

  	# test "name_maximum_45_character" do
  	# 	should validate_length_of(:name).is_at_most(45)
  	# end

  	# test "relation with pokedex" do
  	# 	assert_aqual 1, @pokedex.pokemon.name
  	# end

end
