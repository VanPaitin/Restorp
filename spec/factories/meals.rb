FactoryBot.define do
  factory :meal do
    name { Faker::Food.dish }
    description { Faker::Food.description }
    number_in_stock { Faker::Number.between(1, 10) }
    price "9.99"
    restaurant nil
    cuisine nil
  end
end
