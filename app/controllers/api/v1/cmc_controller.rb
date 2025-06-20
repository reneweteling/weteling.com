module Api
  module V1
    class CmcController < BaseController
      skip_before_action :authenticate_user!, :authenticate_user

      # http://localhost:3000/api/v1/cmc?path=v1/cryptocurrency/listings/latest&query=start%3D2%26limit%3D1000%26convert%3DUSD%26cryptocurrency_type%3Dcoins

      def index
        begin
          response = fetch_cmc_data
          render json: response
        rescue => e
          render json: { error: e.message }, status: :internal_server_error
        end
      end

      private

      def fetch_cmc_data
        require 'net/http'
        require 'json'

        uri = URI("https://pro-api.coinmarketcap.com/#{params[:path]}?#{params[:query]}")

        http = Net::HTTP.new(uri.host, uri.port)
        http.use_ssl = true

        request = Net::HTTP::Get.new(uri)
        request['X-CMC_PRO_API_KEY'] = ENV['CMC_PRO_API_KEY']

        response = http.request(request)

        if response.code == '200'
          JSON.parse(response.body)
        else
          { error: "API request failed with status #{response.code}" }
        end
      end
    end
  end
end
