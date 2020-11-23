require "rails_helper"

RSpec.describe Users::TopCommentersQuery do
  describe "#all" do
    subject(:get_commenters) { described_class.call }

    let!(:users) { create_list(:user, 5) }
    let(:user_with_comment) { create(:user) }

    context "with comments in last week" do
      let!(:comment) { create(:comment, user: user_with_comment, created_at: 6.days.ago) }

      it "returns user with comments" do
        expect(get_commenters).to contain_exactly(user_with_comment)
      end
    end

    context "without comments in last week" do
      let!(:comment) { create(:comment, user: user_with_comment, created_at: 8.days.ago) }

      it "does not return any users" do
        expect(get_commenters).to be_empty
      end
    end
  end
end
