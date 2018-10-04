Rails.application.routes.draw do
  resources :pokemon_battles do 
    patch 'attack', on: :member
    patch 'surrender', on: :member
  end
  resources :pokemons do
  	resources :pokemon_skills
  end
  resources :skills
  resources :pokedexes 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'pages#index'
end