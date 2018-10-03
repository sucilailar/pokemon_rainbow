class Pokedex < ApplicationRecord

	EL_TYPE = ["normal", "fire","fighting", "water", "flying", 
			   "grass", "poison", "electric", "ground", "psychic", 
			   "rock", "ice", "bug", "dragon", "ghost", "dark", 
			   "steel", "fairy"]
	has_many :pokemons
	
	validates :name, length: { maximum:45 }, uniqueness: true
	validates :element_type, length: { maximum: 45 }
	validates :image_url, length: { maximum: 255 }
	validates :base_health_point, presence: true, :numericality => { greater_than: 0}
	validates :base_attack, presence: true, :numericality => { greater_than: 0}
	validates :base_defence, presence: true,  :numericality => { greater_than: 0}
	validates :base_speed, presence: true, :numericality => { greater_than: 0}

	validates :element_type, inclusion: {in:  EL_TYPE}
end
