class PokemonBattleCalculator < TypeChart



	def self.calculate_damage(attacker_pokemon, defender_pokemon, skill_id)

		attacker_level = attacker_pokemon.level
		attacker_attack = attacker_pokemon.attack
		attacker_power = skill_id.power
		defender_defence = defender_pokemon.defence

		random_number = rand(85..100)
		weakness_ressistance = 1
		element_type_pokedex = attacker_pokemon.pokedex.element_type
		element_type_skill = skill_id.element_type
		element_type_attacker = attacker_pokemon.pokedex.element_type
		element_type_defender = defender_pokemon.pokedex.element_type

		# require 'pry'
		# binding.pry

		calculate_resistance = TypeChart::WEAKNESS_RESISTANCE[element_type_attacker.to_sym][element_type_defender.to_sym]

		if element_type_pokedex == element_type_skill
			stab = 1.5
		else
			stab = 1
		end

		damage = ((((2.to_f * attacker_level.to_f)/2.to_f) / 5.to_f + 2.to_f ) * 
				attacker_attack.to_f * attacker_power.to_f / defender_defence.to_f) / 
				50.to_f + 2.to_f * stab.to_f * calculate_resistance.to_f * (random_number.to_f / 100)

		return damage.to_i
	end


	def self.calculate_experience(pokemon_enemy_level)
		random_number = rand(20..150)
		experience_gain = random_number.to_f * pokemon_enemy_level
		return experience_gain
	end

	def self.level_up?(level_winner_id, total_experience_winner_pokemon)

		level_limit = (2**level_winner_id)*100

		if level_limit #jika total expereience >= level limit return true
			return true
		end
	end

	

	
end