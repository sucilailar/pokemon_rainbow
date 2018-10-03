require 'test_helper'

class PokemonSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pokemon_skill = pokemon_skills(:one)
  end

  test "should get index" do
    get pokemon_skills_url
    assert_response :success
  end

  test "should get new" do
    get new_pokemon_skill_url
    assert_response :success
  end

  test "should create pokemon_skill" do
    assert_difference('PokemonSkill.count') do
      post pokemon_skills_url, params: { pokemon_skill: { current_pp: @pokemon_skill.current_pp, pokemon_id: @pokemon_skill.pokemon_id, skill_id: @pokemon_skill.skill_id } }
    end

    assert_redirected_to pokemon_skill_url(PokemonSkill.last)
  end

  test "should show pokemon_skill" do
    get pokemon_skill_url(@pokemon_skill)
    assert_response :success
  end

  test "should get edit" do
    get edit_pokemon_skill_url(@pokemon_skill)
    assert_response :success
  end

  test "should update pokemon_skill" do
    patch pokemon_skill_url(@pokemon_skill), params: { pokemon_skill: { current_pp: @pokemon_skill.current_pp, pokemon_id: @pokemon_skill.pokemon_id, skill_id: @pokemon_skill.skill_id } }
    assert_redirected_to pokemon_skill_url(@pokemon_skill)
  end

  test "should destroy pokemon_skill" do
    assert_difference('PokemonSkill.count', -1) do
      delete pokemon_skill_url(@pokemon_skill)
    end

    assert_redirected_to pokemon_skills_url
  end
end
