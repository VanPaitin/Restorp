FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password 'password'
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
  end
end
