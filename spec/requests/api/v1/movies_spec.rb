require "rails_helper"

RSpec.describe "Movies API V1" do
  describe "GET /movies/:id" do
    let!(:movie) { create(:movie) }
    subject! { get path }

    context "with existing movie id" do
      let(:path) { "/api/v1/movies/#{movie.id}" }

      it "returns the 200 status" do
        expect(response).to have_http_status(200)
      end

      it "returns movie details" do
        expect(json_response["data"]["attributes"]["id"]).to eq(movie.id)
        expect(json_response["data"]["attributes"]["title"]).to eq(movie.title)
      end
    end

    context "with id, that does not exist in db" do
      let(:path) { "/api/v1/movies/#{Movie.maximum(:id).next}" }

      it "returns the 404 status" do
        expect(response).to have_http_status(404)
      end

      it "returns error paylod" do
        expect(json_response["title"]).to eq(I18n.t("errors.not_found.title"))
        expect(json_response["detail"]).to eq(I18n.t("errors.not_found.detail"))
      end
    end
  end

  describe "GET /movies" do
    let!(:movies) { create_list(:movie, 5) }

    let(:path) { "/api/v1/movies" }

    subject! { get path }

    it "returns the 200 status" do
      expect(response).to have_http_status(200)
    end

    it "returns an movie details" do
      expect(json_response["data"].size).to eq(5)

      first_movie = json_response["data"][0]
      expect(first_movie["attributes"]["id"]).to eq(movies.first.id)
      expect(first_movie["attributes"]["title"]).to eq(movies.first.title)
    end
  end
end
