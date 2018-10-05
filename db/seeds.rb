# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'

csv_file_path = "#{Rails.root}/lib/seeds/list_pokedex.csv"
CSV.foreach(csv_file_path, headers: true) do |row|
	Pokedex.create!({
		:name => row[0],
		:base_health_point => row[1],
		:base_attack => row[2],
		:base_defence => row[3],
		:base_speed => row[4],
		:element_type => row[5],
		:image_url => row[6]
	})
	puts "Row Pokedex Added!"
end

csv_file_path_skill = csv_file_path = "#{Rails.root}/lib/seeds/list_skill.csv"
CSV.foreach(csv_file_path_skill, headers: true) do |row|
	Skill.create!({
		:name => row[0],
		:power => row[1],
		:max_pp => row[2],
		:element_type => row[3]
	})
	puts "Row Skill Added!"
end

