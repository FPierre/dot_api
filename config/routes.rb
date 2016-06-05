require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :users, only: [:show, :index, :update], controller: 'users/users'
        post 'sign_in', to: 'users/sessions#create', as: :user_session
        # delete 'users/sign_out', to: 'users/sessions#destroy', as: :destroy_user_session
        # delete 'users', to: 'users/registrations#destroy', as: :destroy_user_registration
        post 'users', to: 'users/registrations#create', as: :user_registration
        # put 'users', to: 'users/registrations#update'
      end

      namespace :screens do
        get 'path/from/:from/to/:to', action: :path
        get 'resize/zone/:zone/size/:size', action: :resize
      end

      namespace :tests do
        get 'ping'
        post 'voice'
      end

      resources :raspberries, only: [:index, :show]
      resources :reminders, only: [:index, :show, :create, :destroy]
      resources :settings, only: [:show, :update]
      resources :voice_commands, only: :index
      resources :weather, only: :show
    end
  end

  devise_for :users, controllers: { registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  root 'tests#ping'

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
end
