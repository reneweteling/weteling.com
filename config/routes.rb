Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "_ah/health", to: "application#health_check"

  resources :graph

  root to: redirect('/admin')

  get :home, to: 'site#home'

  # root to: 'site#home'

end
