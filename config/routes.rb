Rails.application.routes.draw do
  root to: 'todos#home'

  resources :todos do
    member do
      put :first
      put :second
      post :post_update
    end
  end
end
