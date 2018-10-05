class PokemonBattleCalculator < TypeChart

	StatusUp = Struct.new(:health, :attack, :defence, :speed)
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
		if total_experience_winner_pokemon  >= level_limit
			return true
		else
			return false
		end
	end

	def self.calculate_level_up_extra_stats
		health_point = rand(10..20)
		attack_point = rand(1..5)
		defence_point = rand(1..5)
		speed_point = rand(1..5)
		@level_up_bonus = StatusUp.new
		@level_up_bonus.health = health_point
		@level_up_bonus.attack = attack_point
		@level_up_bonus.defence = defence_point
		@level_up_bonus.speed = speed_point
		return @level_up_bonus
	end
end