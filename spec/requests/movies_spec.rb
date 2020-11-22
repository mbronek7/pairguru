require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "movies export and mailer" do
    let(:movie) { create(:movie) }
    context "when user is not logged in" do
      it "send_info redirects to sign in path" do
        visit "/movies/#{movie.id}/send_info"
        expect(page).to have_selector("#flash_alert", text: "You need to sign in or sign up before continuing.")
        expect(page).to have_current_path("/users/sign_in")
      end

      it "export redirects to sign in path" do
        visit "/movies/export"
        expect(page).to have_selector("#flash_alert", text: "You need to sign in or sign up before continuing.")
        expect(page).to have_current_path("/users/sign_in")
      end
    end

    context "when user id signed in" do
      let!(:user) { create(:user) }

      before(:example) do
        sign_in user
      end

      it "completes successfuly for send_info" do
        visit "/movies/#{movie.id}/send_info"
        expect(page).to have_http_status(200)
        expect(page).to have_selector("#flash_notice", text: "Email sent with movie info")
        expect(page).to have_current_path("/")
      end

      it "completes successfuly for export" do
        visit "/movies/export"
        expect(page).to have_http_status(200)
        expect(page).to have_selector("#flash_notice", text: "Movies exported")
        expect(page).to have_current_path("/")
      end
    end
  end
end
