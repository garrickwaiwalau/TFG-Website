Rails.application.routes.draw do
  root "index#index"

  resources :index do
    resources :comments
  end
end
