class Skill < ApplicationRecord
		EL_TYPE = ["normal", "fire","fighting", "water", "flying", 
			   "grass", "poison", "electric", "ground", "psychic", 
			   "rock", "ice", "bug", "dragon", "ghost", "dark", 
			   "steel", "fairy"]

	has_many :pokemon_skills
	has_many :pokemon_battle_logs
	has_many :pokemons, through: :pokemon_skills

	validates :name, uniqueness: true, presence: true, length: { maximum: 45 }
	validates :element_type, length: { maximum: 45 }
	validates :power, presence: true, :numericality => { greater_than: 0}
	validates :max_pp, presence: true, :numericality => { greater_than: 0}


	validates :element_type, inclusion: {in:  EL_TYPE}
end
