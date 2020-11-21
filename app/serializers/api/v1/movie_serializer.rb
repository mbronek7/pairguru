module Api
  module V1
    class MovieSerializer
      include JSONAPI::Serializer
      attributes :id, :title
    end
  end
end
