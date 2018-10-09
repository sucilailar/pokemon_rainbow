Rails.application.routes.draw do
  resources :pokemon_battles do 
    patch 'attack', on: :member
    patch 'surrender', on: :member
    resources :pokemon_battle_logs
  end
  resources :pokemons do
    get 'heal', on: :member
    get 'heal_all', on: :collection
  	resources :pokemon_skills
  end
  resources :skills
  resources :pokedexes 
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to:'pages#index'
end