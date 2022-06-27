# frozen_string_literal: true

Rails.application.routes.draw do
  resources :table_types, only: [] do
    collection do
      get :exchange_rates
    end
  end
end
