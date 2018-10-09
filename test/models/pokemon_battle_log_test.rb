require "test_helper"

describe PokemonBattleLog do
  let(:pokemon_battle_log) { PokemonBattleLog.new }

  it "must be valid" do
    value(pokemon_battle_log).must_be :valid?
  end
end
