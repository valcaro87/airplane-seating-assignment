Rails.application.routes.draw do

  root to: 'airplanes#seating'

  get 'airplane/seating', to: 'airplanes#seating'
end
