# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :ingredients do
    resources :ingredient_stocks
  end
  root to: 'ingredients#index'
end
