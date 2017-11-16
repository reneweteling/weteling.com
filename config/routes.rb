Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    post "/graphql", to: "graphql#execute"
  end

  get "_ah/health", to: "application#health_check"

  post :contact, to: 'site#contact'
  

  get :cv, to: 'site#cv'
  get :cv_print, to: 'site#cv_print'
  get :cv_pdf, to: 'site#cv_pdf'
  root to: 'site#home'

end
