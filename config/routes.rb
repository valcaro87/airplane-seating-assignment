Rails.application.routes.draw do

  root to: 'airplanes#index'

  resources :airplanes # do
    # resources :seatings
  # end

  resources :seatings

  # get 'airplane/seating', to: 'airplanes#seating'
end
