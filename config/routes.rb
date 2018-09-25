# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :kids, only: [:index]
  resources :premium_users, only: [:index]
  resources :rude_users, only: [:index]

  # NOTE singular resource
  # resource :city, only: %i[edit update]

  namespace :users do
    resource :city, only: %i[edit update]
  end

  resources :movies do
    collection do
      get "search"
    end
    resources :reviews, except: %i[show index]
  end

  resources :users, only: %i[index show] do
    put "toggle_block", on: :member
  end

  root "movies#index"
end
