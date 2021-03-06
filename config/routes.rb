Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  #   post "/graphql", to: "graphql#execute"
  # end

  get "_ah/health", to: "application#health_check"

  match "error/:code", to: "errors#show", constraints: { code: /\d+/ }, via: :all

  post :contact, to: 'site#contact'
  post :subscribe, to: 'site#subscribe'

  get :cv, to: 'site#cv'
  get :cv_print, to: 'site#cv_print'
  get :cv_pdf, to: 'site#cv_pdf'
  root to: 'site#home'

end
