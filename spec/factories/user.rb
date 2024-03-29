FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    confirmed_at { Time.now }
    password "password"
  end
end
