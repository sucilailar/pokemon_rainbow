require "application_system_test_case"

class PokedexesTest < ApplicationSystemTestCase
  setup do
    @pokedex = pokedexes(:one)
  end

  test "visiting the index" do
    visit pokedexes_url
    assert_selector "h1", text: "Pokedexes"
  end

  test "creating a Pokedexe" do
    visit pokedexes_url
    click_on "New Pokedexe"

    fill_in "Base Attack", with: @pokedex.base_attack
    fill_in "Base Defence", with: @pokedex.base_defence
    fill_in "Base Health Point", with: @pokedex.base_health_point
    fill_in "Base Speed", with: @pokedex.base_speed
    fill_in "Element Type", with: @pokedex.element_type
    fill_in "Image Url", with: @pokedex.image_url
    fill_in "Name", with: @pokedex.name
    click_on "Create Pokedexe"

    assert_text "Pokedexe was successfully created"
    click_on "Back"
  end

  test "updating a Pokedexe" do
    visit pokedexes_url
    click_on "Edit", match: :first

    fill_in "Base Attack", with: @pokedex.base_attack
    fill_in "Base Defence", with: @pokedex.base_defence
    fill_in "Base Health Point", with: @pokedex.base_health_point
    fill_in "Base Speed", with: @pokedex.base_speed
    fill_in "Element Type", with: @pokedex.element_type
    fill_in "Image Url", with: @pokedex.image_url
    fill_in "Name", with: @pokedex.name
    click_on "Update Pokedexe"

    assert_text "Pokedexe was successfully updated"
    click_on "Back"
  end

  test "destroying a Pokedex" do
    visit pokedexes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Pokedex was successfully destroyed"
  end
end
