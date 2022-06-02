# frozen_string_literal: true

Rails.application.routes.draw do
  get '/users/:id/clear/', to: 'users#clear_avatar', as: 'clear_avatar'

  resource :sessions, only: %i[new create destroy]

  resources :users

  resource :logs, only: %i[show]

  resources :posts do
    resources :comments, except: %i[new show]
  end

  namespace :admin do
    resources :users, only: %i[index create edit update destroy]
    resources :logs, only: %i[index]
  end

  root 'posts#index'
end
