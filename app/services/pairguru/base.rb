module Pairguru
  class Base
    ENDPOINT = "https://pairguru-api.herokuapp.com".freeze

    def initialize(args = {})
      @endpoint = args.fetch(:endpoint, ENDPOINT)
    end

    private

    attr_reader :endpoint

    def endpoint_url(path)
      "#{endpoint}#{path}"
    end

    def parse(response)
      Oj.load(response.body, symbol_keys: true)[:data]
    end
  end
end
