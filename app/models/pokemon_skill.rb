class PokemonSkill < ApplicationRecord
	belongs_to :skill
	belongs_to :pokemon

	validates :skill_id, uniqueness: { scope: :pokemon_id }
	validates :current_pp, presence: true,  :numericality => { greater_than: 0 }
	validate :val_current_pp_max_pp

	def val_current_pp_max_pp
		max_pp = Skill.find(skill_id).max_pp
		if current_pp > max_pp
			errors[:base] << "Current PP more tha Max PP!!"
		end
	end



end
