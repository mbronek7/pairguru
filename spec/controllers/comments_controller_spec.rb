require "rails_helper"

describe CommentsController, type: :controller do
  describe "POST comments" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      context "with valid attributes" do
        let(:movie) { create(:movie) }
        let(:params) { { comment: { body: Faker::Lorem.sentence }, movie_id: movie.id } }

        it "creates a new comment" do
          expect do
            post :create, params: params
          end.to change(Comment, :count).by(1)
        end

        it "redirects to movie" do
          post :create, params: params
          response.should redirect_to movie
        end
      end

      context "with invalid attributes" do
        let(:movie) { create(:movie) }
        let(:params) { { comment: { body: nil }, movie_id: movie.id } }
        it "does not save the new comment" do
          expect do
            post :create, params: params
          end.to_not change(Comment, :count)
        end

        it "redirects to movie" do
          post :create, params: params
          response.should redirect_to movie
        end
      end
    end

    context "when user is not signed in" do
      let(:movie) { create(:movie) }
      let(:params) { { comment: { body: Faker::Lorem.sentence }, movie_id: movie.id } }

      it "redirects to sign in page" do
        post :create, params: params
        response.should redirect_to new_user_session_path
      end
    end
  end

  describe "DELETE comments" do
    context "when user is signed in" do
      let(:user) { create(:user) }

      before :each do
        sign_in user
      end

      context "when user is author of comment" do
        let!(:comment) { create(:comment, user: user) }

        it "deletes user comment" do
          expect do
            delete :destroy, params: { id: comment.id, movie_id: comment.movie.id }
          end.to change(Comment, :count).by(-1)
        end
      end

      context "when user is not author of comment" do
        let!(:comment) { create(:comment) }

        it "does not delete user comment" do
          expect do
            delete :destroy, params: { id: comment.id, movie_id: comment.movie.id }
          end.not_to change(Comment, :count)
        end
      end
    end
    context "when user is not signed in" do
      let!(:comment) { create(:comment) }
      let(:movie) { create(:movie) }

      it "redirects to sign in page" do
        delete :destroy, params: { id: comment.id, movie_id: comment.movie.id }
        response.should redirect_to new_user_session_path
      end
    end
  end
end
