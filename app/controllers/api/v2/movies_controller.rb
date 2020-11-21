module Api
  module V2
    class MoviesController < Api::BaseController
      def index
        get_movies
      end

      def show
        render_json(serializer, movie)
      end

      private

      def serializer
        Api::V2::MovieSerializer
      end

      def movie
        @movie ||= Movie.find(params[:id])
      end

      def get_movies
        page = params[:page] || 1
        render_json(serializer, Movie.page(page).per(10))
      end
    end
  end
end
