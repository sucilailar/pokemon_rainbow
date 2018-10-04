class PokemonBattle < ApplicationRecord
	belongs_to :pokemon1, class_name: 'Pokemon'
	belongs_to :pokemon2, class_name: 'Pokemon'
	belongs_to :pokemon_winner, class_name: 'Pokemon'
	belongs_to :pokemon_loser, class_name: 'Pokemon'



	validate :val_p1_not_same_with_p2 
	validate :current_hp_pokemon1_greater_than_0, if: :new_record?
	validate :current_hp_pokemon2_greater_than_0, if: :new_record?


	def val_p1_not_same_with_p2
		# require 'pry'
		# binding.pry
		if pokemon1_id == pokemon2_id
			errors[:base] << "Player 1 same with Player 2"
		end
	end
# @pokemon_battle.pokemon2.current_health_point
	def current_hp_pokemon1_greater_than_0
    	pokemon2 = Pokemon.find(pokemon2_id)
			if pokemon1.current_health_point == 0
				errors[:base] << "Pokemon 1 have 0 health point"
			end
	end

	def current_hp_pokemon2_greater_than_0
    	pokemon2 = Pokemon.find(pokemon2_id)
			if pokemon2.current_health_point == 0
				errors[:base] << "Pokemon 2 have 0 health point"
			end
	end

end
