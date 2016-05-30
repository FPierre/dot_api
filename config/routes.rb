require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  namespace :api do
    namespace :v1 do
      get 'ping', to: 'ping#ping', as: :ping

      get 'voice-commands', to: 'voice_commands#index'

      # TODO Utile ?
      get 'users/current-user', to: 'users/users#current_user', as: :current_user

      devise_scope :user do
        resources :users, only: [:show, :index, :update], controller: 'users/users'
        post 'sign_in', to: 'users/sessions#create', as: :user_session
        # delete 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
        # delete 'users', to: 'users/registrations#destroy', as: :destroy_user_registration
        post 'users', to: 'users/registrations#create', as: :user_registration
        # put 'users', to: 'users/registrations#update'
      end

      scope 'dashboard', controller: :dashboard do
        get 'path/from/:from/to/:to', action: :path
      end

      # scope 'settings', controller: :settings do
      #   post 'reminders-state', action: :reminders_state, as: :reminders_state
      #   post 'sarah-state', action: :sarah_state, as: :sarah_state
      #   post 'twitter-state', action: :twitter_state, as: :twitter_state
      #   post 'weather-state', action: :weather_state, as: :weather_state
      #   # post 'metting-room-state', action: :metting_room_state, as: :metting_room_state
      #   # get 'sarah-commands', action: :sarah_commands, as: :sarah_commands
      # end

      resources :settings, only: [:show, :update]
      resources :reminders, only: [:index, :show, :create, :destroy]
    end
  end

  devise_for :users, controllers: { registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  root 'ping#ping'

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
end
