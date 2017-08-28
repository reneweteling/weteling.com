Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get "_ah/health", to: "application#health_check"
  
  get :home, to: 'site#home'

  root to: 'site#home'

end
