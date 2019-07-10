Rails.application.routes.draw do
  root to: 'game#index'
  resources :game do
  end
end
