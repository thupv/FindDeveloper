FactoryBot.define do
  factory :developer do
    email { Faker::Internet.email }
  end
end
