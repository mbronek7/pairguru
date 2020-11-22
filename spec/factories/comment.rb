FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user { create(:user) }
  end
end
