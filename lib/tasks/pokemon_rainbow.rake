 

namespace :pokemon_rainbow do
	desc "Import CSV data from Pokedex"
	task drop_and_seed: [ 'db:drop', 'db:create', 'db:migrate', 'db:seed' ]  do
	end
end

