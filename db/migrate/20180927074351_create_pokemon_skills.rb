class CreatePokemonSkills < ActiveRecord::Migration[5.2]
  def change
    create_table :pokemon_skills do |t|
      t.integer :skill_id
      t.integer :pokemon_id
      t.integer :current_pp

      t.timestamps
    end
     add_foreign_key :pokemon_skills, :pokemons, column: :pokemon_id
     add_foreign_key :pokemon_skills, :skills, column: :skill_id
  end
end
