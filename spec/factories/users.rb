FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password 'password'
  end
end
