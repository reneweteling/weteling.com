Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "_ah/health", to: "application#health_check"

  root to: redirect('/admin')
end
