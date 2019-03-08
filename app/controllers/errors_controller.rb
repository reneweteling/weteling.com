class ErrorsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def show
    render json: {error: params[:code]}, status: params[:code]
  end
end
