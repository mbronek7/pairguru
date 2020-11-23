FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user { create(:user) }
    movie { create(:movie) }
  end
end
