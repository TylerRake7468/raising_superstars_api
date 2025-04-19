Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :programs, only: [:index, :show] do
        resources :days, only: [:index, :show]
      end
    end
  end
end
