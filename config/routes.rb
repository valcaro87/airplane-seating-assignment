Rails.application.routes.draw do
  resources :airplanes

  get 'airplane/seating', to: 'airplanes#seating'
end