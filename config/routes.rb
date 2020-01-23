Rails.application.routes.draw do
  devise_for :managers
  devise_for :employees

  namespace :api do
    namespace :v1 do
      namespace :managers do
        resources :employees, except: %i[new edit]
        resources :avaliations, except: %i[new edit]

        post '/sign_in' => 'sessions#create'

        root to: 'avaliations#index'
      end

      namespace :employees do
        resources :avaliations, only: %i[index show]

        post '/sign_in' => 'sessions#create'

        root to: 'avaliations#index'
      end
    end
  end
end
