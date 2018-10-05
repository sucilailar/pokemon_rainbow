class BattleEngine

	attr_reader :attacker, :defender, :skill, :pokemon_battle
	def initialize(attacker, defender, skill, pokemon_battle_id, action_params)
		@attacker = attacker
		@defender = defender
		@skill = skill
		@pokemon_battle = pokemon_battle_id
		@action_params = action_params
	end

	def valid_next_turn?
		if @pokemon_battle.state == "ongoing"
				return true
			else
				return false
		end
	end

	def next_turn!
		if @action_params == "attack"
			attack_engine!
		else
			surrender_engine!
		end
		save!
	end

	def surrender_engine!
		@pokemon_skill = PokemonSkill.find_by(pokemon_id: @attacker.id, skill_id: @skill)
		@pokemon_battle.pokemon_winner_id = defender.id
    @pokemon_battle.pokemon_loser_id = attacker.id
    @pokemon_battle.state = "finish"
    if @pokemon_battle.pokemon_winner_id.present?
      loser = Pokemon.find(@pokemon_battle.pokemon_loser_id)
      winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)  
        enemy_level = loser.level
        experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
        winner.current_experience = winner.current_experience + experience_gain
        @pokemon_battle.experience_gain = experience_gain
        is_level_up = PokemonBattleCalculator.level_up?(winner.level, winner.current_experience)
      if is_level_up == true
         new_level = Math::log2(winner.current_experience) - 5
         status_up = PokemonBattleCalculator.calculate_level_up_extra_stats
         winner.level = new_level
         winner.current_health_point = winner.current_health_point + status_up.health
         winner.attack = winner.attack + status_up.attack
         winner.defence = winner.defence + status_up.defence
         winner.speed = winner.speed + status_up.speed  
      end
      winner.save
    end
	end

	def attack_engine!
		@pokemon_skill = PokemonSkill.find_by(pokemon_id: @attacker.id, skill_id: @skill)
    damage = PokemonBattleCalculator.calculate_damage(@attacker, @defender, @skill) 
    if @defender.current_health_point < damage
         @defender.current_health_point = 0
    else
          min_hp = @defender.current_health_point - damage
          @defender.current_health_point = min_hp
    end
    @pokemon_battle.current_turn += 1
    @pokemon_skill.current_pp -= 1
    if @defender.current_health_point == 0 || @attacker.current_health_point == 0
      if @defender.current_health_point == 0
        @pokemon_battle.pokemon_winner_id = @attacker.id
        @pokemon_battle.pokemon_loser_id = @defender.id
        @pokemon_battle.state = "finish"
      else
        @pokemon_battle.pokemon_winner_id = @defender.id
        @pokemon_battle.pokemon_loser_id = @attacker.id
        @pokemon_battle.state = "finish"
      end
    end
    if @pokemon_battle.pokemon_winner_id.present?
      loser = Pokemon.find(@pokemon_battle.pokemon_loser_id)
      winner = Pokemon.find(@pokemon_battle.pokemon_winner_id)  
        enemy_level = loser.level
        experience_gain = PokemonBattleCalculator.calculate_experience(loser.level)
        winner.current_experience = winner.current_experience + experience_gain
        @pokemon_battle.experience_gain = experience_gain
        is_level_up = PokemonBattleCalculator.level_up?(winner.level, winner.current_experience)
      if is_level_up == true
         new_level = Math::log2(winner.current_experience) - 6
         status_up = PokemonBattleCalculator.calculate_level_up_extra_stats
         winner.level = new_level
         winner.current_health_point = winner.current_health_point + status_up.health
         winner.attack = winner.attack + status_up.attack
         winner.defence = winner.defence + status_up.defence
         winner.speed = winner.speed + status_up.speed  
      end
      winner.save
    end
	end 

	def save!
		@pokemon_skill.save
    @defender.save
    @pokemon_battle.save
	end

end