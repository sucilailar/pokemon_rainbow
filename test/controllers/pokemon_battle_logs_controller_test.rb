require "test_helper"

describe PokemonBattleLogsController do
  let(:pokemon_battle_log) { pokemon_battle_logs :one }

  it "gets index" do
    get pokemon_battle_logs_url
    value(response).must_be :success?
  end

  it "gets new" do
    get new_pokemon_battle_log_url
    value(response).must_be :success?
  end

  it "creates pokemon_battle_log" do
    expect {
      post pokemon_battle_logs_url, params: { pokemon_battle_log: { action_type: pokemon_battle_log.action_type, attacker_current_health_point: pokemon_battle_log.attacker_current_health_point, attacker_id: pokemon_battle_log.attacker_id, defender_current_health_point: pokemon_battle_log.defender_current_health_point, defender_id: pokemon_battle_log.defender_id, pokemon_battle_id: pokemon_battle_log.pokemon_battle_id, turn: pokemon_battle_log.turn } }
    }.must_change "PokemonBattleLog.count"

    must_redirect_to pokemon_battle_log_path(PokemonBattleLog.last)
  end

  it "shows pokemon_battle_log" do
    get pokemon_battle_log_url(pokemon_battle_log)
    value(response).must_be :success?
  end

  it "gets edit" do
    get edit_pokemon_battle_log_url(pokemon_battle_log)
    value(response).must_be :success?
  end

  it "updates pokemon_battle_log" do
    patch pokemon_battle_log_url(pokemon_battle_log), params: { pokemon_battle_log: { action_type: pokemon_battle_log.action_type, attacker_current_health_point: pokemon_battle_log.attacker_current_health_point, attacker_id: pokemon_battle_log.attacker_id, defender_current_health_point: pokemon_battle_log.defender_current_health_point, defender_id: pokemon_battle_log.defender_id, pokemon_battle_id: pokemon_battle_log.pokemon_battle_id, turn: pokemon_battle_log.turn } }
    must_redirect_to pokemon_battle_log_path(pokemon_battle_log)
  end

  it "destroys pokemon_battle_log" do
    expect {
      delete pokemon_battle_log_url(pokemon_battle_log)
    }.must_change "PokemonBattleLog.count", -1

    must_redirect_to pokemon_battle_logs_path
  end
end
