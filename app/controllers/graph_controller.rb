class GraphController < ApplicationController
  # Use :null_session here
  protect_from_forgery with: :null_session
  skip_before_filter :verify_authenticity_token

  def index
    render json: Schema.execute(GraphQL::Introspection::INTROSPECTION_QUERY)
  end

  def create
    query_string = params[:query]
    query_variables = params[:variables] || {}
    result = Schema.execute(query_string, variables: query_variables)
    render json: result
  end
end