class PokemonBattleCalculator

	attr_accesor :attacker_pokemon, :defender_pokemon, :skill_id

		pokemon_battle1 = PokemonBattle.find(pokemon1_id)
		pokemon_battle2 = PokemonBattle.find(pokemon2_id)
		@pokemon_battle = PokemonBattle.find(pokemon_battle_id)
		pokemon1 = Pokemon.find(pokemon1_battle)
		pokemon2 = Pokemon.find(pokemon2_battle)

		pokemon_skill1 = PokemonSkill.find(pokemon1_battle)
		pokemon_skill2 = PokemonSkill.find(pokemon2_battle)

		level_pokemon1 = pokemon1.level
		level_pokemon2 = pokemon2.level

		skill_id1 = pokemon_skill1.skill_id
		skill_id2 = pokemon_skill2.skill_id

		@turn = pokemon_battle.current_turn
		
		# attacker_pokemon
		# defender_pokemon
		# skill_id




	def self.calculate_damage(attacker_pokemon, defender_pokemon, skill_id)
		#harus tau turn siapa dlu
		player_turn = @turn
			loop do
				player_turn += 1
				if player_turn % 2 == 0
					attacker_pokemon = pokemon2_id
					defender_pokemon = pokemon1_id
				else 
					attacker_pokemon = pokemon1_id
					defender_pokemon = pokemon2_id
				end
			end
	end

		damage = (2*level / 5 + 2) * attacker_pokemon * 
		return damage
	end

	def action_attack
		masuk ke skill_id
	end

	def winning_lose_condition
	end

	def surrender
	end

	def experience_pokemon_win_battle
	end

	def increase_level
	end

	def increase_status
	end


end