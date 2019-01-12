Rails.application.routes.draw do
  resources :products, only: [:index, :show, :update]

  resources :shopping_carts, only: [:index, :show, :create, :update]
end
