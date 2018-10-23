FactoryBot.define do
  factory :meal_order do
    meal
    order
    quantity 1
    total_price "9.99"
  end
end
