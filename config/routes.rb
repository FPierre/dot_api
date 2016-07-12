require 'sidekiq/web'

Rails.application.routes.draw do
  apipie

  namespace :api do
    namespace :v1 do
      devise_scope :user do
        resources :users, only: [:show, :index, :update, :destroy], controller: 'users/users'

        post 'sign_in', to: 'users/sessions#create', as: :user_session
        post 'users', to: 'users/registrations#create', as: :user_registration
      end

      namespace :screens do
        get 'path/from/:from/to/:to', action: 'path'
        get 'resize/zone/:zone/size/:size', action: 'resize'
      end

      namespace :tests do
        get 'ping'
        post 'voice'
      end

      resources :raspberries, only: [:index, :show, :create, :update, :destroy]
      resources :reminders, only: [:index, :show, :create, :destroy] do
        delete :erase_all, on: :collection
      end
      resources :settings, only: [:show, :update] do
        put 'sarah_enabled'
      end
      resources :voice_commands, only: :index
      resources :voice_recognition_servers, only: [:show, :update]

      get :weather, to: 'weather#show'
    end
  end

  devise_for :users, controllers: { registrations: 'api/v1/users/registrations', sessions: 'api/v1/users/sessions' }
  devise_for :users, skip: [:sessions, :passwords, :registrations]

  root 'tests#ping'

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
end
