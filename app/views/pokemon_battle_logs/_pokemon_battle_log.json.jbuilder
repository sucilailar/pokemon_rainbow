json.extract! pokemon_battle_log, :id, :pokemon_battle_id, :turn, :attacker_id, :attacker_current_health_point, :defender_id, :defender_current_health_point, :action_type, :created_at, :updated_at
json.url pokemon_battle_log_url(pokemon_battle_log, format: :json)
