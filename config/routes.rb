Rails.application.routes.draw do
  devise_for :managers
  devise_for :employees

  namespace :managers do
    resources :employees, except: %i[new edit]
    resources :avaliations, except: %i[new edit]
  end

  namespace :employees do
    resources :avaliations, only: %i[index show]
  end
end
