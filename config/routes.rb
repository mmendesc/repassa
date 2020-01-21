Rails.application.routes.draw do
  devise_for :managers

  namespace :managers do
    resources :employees
    resources :avaliations
  end
end
