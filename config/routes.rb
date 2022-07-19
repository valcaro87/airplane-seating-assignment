Rails.application.routes.draw do

  root to: 'airplanes#seating'

  resources :airplanes # do
    # resources :seatings
  # end

  resources :seatings

  # get 'airplane/seating', to: 'airplanes#seating'
end
