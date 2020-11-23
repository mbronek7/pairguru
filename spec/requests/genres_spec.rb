require "rails_helper"

describe "Genres requests", type: :request do
  let!(:genres) { create_list(:genre, 5, :with_movies) }

  describe "genre list" do
    before :each do
      allow_any_instance_of(MovieDecorator)
        .to receive_messages(cover: "foo.jpg", plot: "plot", rating: 5.5)
    end

    it "displays only related movies" do
      visit "/genres/" + genres.sample.id.to_s + "/movies"
      expect(page).to have_selector("table tr", count: 5)
    end
  end
end
