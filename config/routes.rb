Rails.application.routes.draw do
  get 'developer/list'
  root to: 'developer#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
