require "application_system_test_case"

class PokemonBattlesTest < ApplicationSystemTestCase
  setup do
    @pokemon_battle = pokemon_battles(:one)
  end

  test "visiting the index" do
    visit pokemon_battles_url
    assert_selector "h1", text: "Pokemon Battles"
  end

  test "creating a Pokemon battle" do
    visit pokemon_battles_url
    click_on "New Pokemon Battle"

    fill_in "Current Turn", with: @pokemon_battle.current_turn
    fill_in "Experience Gain", with: @pokemon_battle.experience_gain
    fill_in "Pokemon1", with: @pokemon_battle.pokemon1_id
    fill_in "Pokemon1 Max Health Point", with: @pokemon_battle.pokemon1_max_health_point
    fill_in "Pokemon2", with: @pokemon_battle.pokemon2_id
    fill_in "Pokemon 2 Max Health Point", with: @pokemon_battle.pokemon_2_max_health_point
    fill_in "Pokemon Loser", with: @pokemon_battle.pokemon_loser_id
    fill_in "Pokemon Winner", with: @pokemon_battle.pokemon_winner_id
    fill_in "State", with: @pokemon_battle.state
    click_on "Create Pokemon battle"

    assert_text "Pokemon battle was successfully created"
    click_on "Back"
  end

  test "updating a Pokemon battle" do
    visit pokemon_battles_url
    click_on "Edit", match: :first

    fill_in "Current Turn", with: @pokemon_battle.current_turn
    fill_in "Experience Gain", with: @pokemon_battle.experience_gain
    fill_in "Pokemon1", with: @pokemon_battle.pokemon1_id
    fill_in "Pokemon1 Max Health Point", with: @pokemon_battle.pokemon1_max_health_point
    fill_in "Pokemon2", with: @pokemon_battle.pokemon2_id
    fill_in "Pokemon 2 Max Health Point", with: @pokemon_battle.pokemon_2_max_health_point
    fill_in "Pokemon Loser", with: @pokemon_battle.pokemon_loser_id
    fill_in "Pokemon Winner", with: @pokemon_battle.pokemon_winner_id
    fill_in "State", with: @pokemon_battle.state
    click_on "Update Pokemon battle"

    assert_text "Pokemon battle was successfully updated"
    click_on "Back"
  end

  test "destroying a Pokemon battle" do
    visit pokemon_battles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pokemon battle was successfully destroyed"
  end
end
