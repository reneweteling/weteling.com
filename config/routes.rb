Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # if Rails.env.development?
  #   mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  #   post "/graphql", to: "graphql#execute"
  # end
  #
  constraints subdomain: 'url462' do
    get '*path', to: 'sendgrid#email_proxy'
  end

  namespace :api do
    devise_for :users, controllers: { sessions: 'api/sessions' },
                          path_names: { sign_in: :login }
    namespace :v1 do
      jsonapi_resources :projects
      jsonapi_resources :hours
      resources :cmc, only: [:index]
    end
  end

  get "_ah/health", to: "application#health_check"

  match "error/:code", to: "errors#show", constraints: { code: /\d+/ }, via: :all

  post :contact, to: 'site#contact'
  post :subscribe, to: 'site#subscribe'

  get :cv, to: 'site#cv'
  get :cv_print, to: 'site#cv_print'
  get :cv_pdf, to: 'site#cv_pdf'
  get :bbq, to: 'site#bbq'
  root to: 'site#home'

end
