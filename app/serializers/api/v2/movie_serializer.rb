module Api
  module V2
    class MovieSerializer
      include JSONAPI::Serializer
      attributes :id, :title
      attribute :genre do |object|
        GenreSerializer.new(object.genre)
      end
    end
  end
end
