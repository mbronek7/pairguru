require "rails_helper"

describe Comment do
  let(:movie) { create(:movie) }
  let(:user) { create(:user) }

  subject { described_class.new }

  it "is valid with valid attributes" do
    subject.body = Faker::Lorem.sentence
    subject.user_id = user.id
    subject.movie_id = movie.id
    expect(subject).to be_valid
  end

  it 'user can only add one comment to movie' do
  	create(:comment, user: user, movie: movie)
    expect do
      create(:comment, user: user, movie: movie)
    end.to raise_error(ActiveRecord::RecordInvalid)
  end
end
