# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'util#welcome'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :debtors
  resources :users
  resources :debts
  patch 'aggregate', to: 'util#aggregate'
  patch 'reset', to: 'util#reset'

  delete 'transactions', to: 'transactions#destroy'
end
