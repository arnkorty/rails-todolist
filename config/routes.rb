Rails.application.routes.draw do
  resources :todos do
    collection do
      put :move
      put :toggle
    end
  end
  devise_for :accounts
  root 'todos#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
