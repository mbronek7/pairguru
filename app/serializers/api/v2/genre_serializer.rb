module Api
  module V2
    class GenreSerializer
      include JSONAPI::Serializer
      attributes :id, :name, :movies_count
    end
  end
end
