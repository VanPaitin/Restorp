FactoryBot.define do
  factory :meal do
    restaurant
    cuisine
    name { Faker::Food.dish }
    description { Faker::Food.description }
    number_in_stock { Faker::Number.between(1, 10) }
    price "9.99"
  end
end
