require "rails_helper"

describe "Movies requests", type: :request do
  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end
  end

  describe "comments section" do
    let!(:movie) { create(:movie, :with_comments) }

    before :each do
      allow_any_instance_of(MovieDecorator)
        .to receive_messages(cover: "foo.jpg", plot: "plot", rating: 5.5)
    end

    it "displays all comments" do
      visit "/movies/#{movie.id}"
      expect(page).to have_selector("h1", text: "Comments")
      expect(page).to have_selector("tr.comment", count: movie.comments.count)
    end

    context "when user is signed in" do
      let!(:user) { create(:user) }

      before :each do
        sign_in user
      end

      it "has comments form" do
        visit "/movies/#{movie.id}"
        expect(page).to have_selector(".comment-form")
      end
    end

    context "when user is not signed in" do
      it "has not got comments form" do
        visit "/movies/#{movie.id}"
        expect(page).not_to have_selector(".comment-form")
      end
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

    context "when user is signed in" do
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
