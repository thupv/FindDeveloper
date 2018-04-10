Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :developer, only: [:show]
    end
  end
  get 'developer/list'
  root to: 'developer#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
