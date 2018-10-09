class PokemonBattleLog < ApplicationRecord
	#1 log, banyak pokemon_battle_id
	#turn ke pokemon_battle
	#1 log punya banyak attacker dan defender
	#action_type ke pokemon_battle
	belongs_to :pokemon_battle
	belongs_to :skill
	belongs_to :attacker, class_name: 'Pokemon'
	#
	belongs_to :defender, class_name: 'Pokemon'
end
