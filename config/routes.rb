Rails.application.routes.draw do
  devise_for :employees
  devise_for :managers

  resources :employees
  resources :avaliations
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
