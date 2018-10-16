FactoryBot.define do
  factory :restaurant do
    city
    is_active { Faker::Boolean.boolean }
    name { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    logo { Faker::Internet.url }
    rating { Faker::Number.between(1, 10) }
    review_number { Faker::Number.between(1, 10) }
    address { Faker::Address.full_address }
    post_code { Faker::Address.postcode }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    is_delivery_enabled { Faker::Boolean.boolean }
    is_pickup_enabled { Faker::Boolean.boolean }
    is_preorder_enabled { Faker::Boolean.boolean }
    web_path { Faker::Internet.url }
    url_key "my-string"
    is_new { Faker::Boolean.boolean }
    schedules ""
  end
end
