module Pairguru
  module Resources
    class Movies < Client
      def get(title)
        response = RestClient::Request.execute(
          method: :get,
          url: endpoint_url("/api/v1/movies/#{URI.escape(title)}")
        )
        parse(response)
      rescue RestClient::BadRequest, RestClient::NotFound
        nil
      end
    end
  end
end
