require "application_system_test_case"

class PokemonSkillsTest < ApplicationSystemTestCase
  setup do
    @pokemon_skill = pokemon_skills(:one)
  end

  test "visiting the index" do
    visit pokemon_skills_url
    assert_selector "h1", text: "Pokemon Skills"
  end

  test "creating a Pokemon skill" do
    visit pokemon_skills_url
    click_on "New Pokemon Skill"

    fill_in "Current Pp", with: @pokemon_skill.current_pp
    fill_in "Pokemon", with: @pokemon_skill.pokemon_id
    fill_in "Skill", with: @pokemon_skill.skill_id
    click_on "Create Pokemon skill"

    assert_text "Pokemon skill was successfully created"
    click_on "Back"
  end

  test "updating a Pokemon skill" do
    visit pokemon_skills_url
    click_on "Edit", match: :first

    fill_in "Current Pp", with: @pokemon_skill.current_pp
    fill_in "Pokemon", with: @pokemon_skill.pokemon_id
    fill_in "Skill", with: @pokemon_skill.skill_id
    click_on "Update Pokemon skill"

    assert_text "Pokemon skill was successfully updated"
    click_on "Back"
  end

  test "destroying a Pokemon skill" do
    visit pokemon_skills_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pokemon skill was successfully destroyed"
  end
end
