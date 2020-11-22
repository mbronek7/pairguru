require "rails_helper"

RSpec.describe MoviesExportJob, type: :job do
  let!(:user) { create(:user) }
  let!(:movies) { create_list(:movie, 5) }

  it "enqueues job properly" do
    expect do
      described_class.perform_later(user.id)
    end.to have_enqueued_job(described_class).with(user.id)
  end
end
