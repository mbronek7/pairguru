require "rails_helper"

describe "Home requests", type: :request do
  let!(:movie) { create(:movie, :with_comments) }

  describe "top commenters" do
    it "displays list with commentators" do
      visit "/commenters"
      expect(page).to have_selector("h1", text: "Top Commenters")
      expect(page).to have_selector(".commentator", count: 5)
    end
  end
end
