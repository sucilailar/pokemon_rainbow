class Pokemon < ApplicationRecord
	validates :name, uniqueness: true, presence: true
	belongs_to :pokedex

	has_many :pokemon_skills
	has_many :skills, through: :pokemon_skills
	has_many :pokemon_battles

	validates :current_health_point, presence: true,  :numericality => { less_than_or_equal_to: :max_health_point, greater_than_or_equal_to: 0}
	validates :current_experience, presence: true,  :numericality => { greater_than_or_equal_to: 0}
	validates :max_health_point, presence: true,  :numericality => {  greater_than: 0}
	validates :attack, presence: true,  :numericality => {  greater_than: 0}
	validates :defence, presence: true,  :numericality => {  greater_than: 0}
	validates :speed, presence: true,  :numericality => {  greater_than: 0}
	validates :level, presence: true,  :numericality => {  greater_than: 0}
	

	 
end
