# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'ingredients#index'
  devise_for :users
  get 'up' => 'rails/health#show', as: :rails_health_check
  resources :ingredients, only: %i[index show new edit create update destroy] do
    resources :ingredient_stocks, only: %i[index show new edit create update destroy]
  end
end
