require "rails_helper"

RSpec.describe "Movies API V2" do
  describe "GET /movies/:id" do
    let!(:movie) { create(:movie) }
    subject! { get path }

    context "with existing movie id" do
      let(:path) { "/api/v2/movies/#{movie.id}" }

      it "returns the 200 status" do
        expect(response).to have_http_status(200)
      end

      it "returns movie details" do
        expect(json_response["data"]["attributes"]["id"]).to eq(movie.id)
        expect(json_response["data"]["attributes"]["title"]).to eq(movie.title)
      end
    end

    context "with id, that does not exist in db" do
      let(:path) { "/api/v2/movies/#{Movie.maximum(:id).next}" }

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
    let!(:genres) { create_list(:genre, 5, :with_movies) }

    let(:path) { "/api/v2/movies" }

    subject! { get path }

    it "returns the 200 status" do
      expect(response).to have_http_status(200)
    end

    it "returns an movie details" do
      data = json_response["data"]
      expect(data.size).to eq(10)

      first_movie = data[0]
      expect(first_movie["attributes"]["id"]).to be_present
      expect(first_movie["attributes"]["title"]).to be_present
    end

    it "returns genre details with movie" do
      data = json_response["data"]
      expect(data.size).to eq(10)

      genre = data[0]["attributes"]["genre"]["data"]
      expect(genre["attributes"]["id"]).to be_present
      expect(genre["attributes"]["name"]).to be_present
      expect(genre["attributes"]["movies_count"]).to be_present
    end
  end
end
