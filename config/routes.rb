Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :programs, only: [:index, :show] do
        resources :days, only: [:index]
      end
      resources :days, only: [:show] do
        get "activities", to: "daily_activities#index"
      end

      resources :completions, only: [:create, :destroy]

      resources :users, only:[] do
        get "completions", to: "completions#index"
        get 'progress', to: 'users#progress'
      end

    end
  end
end
