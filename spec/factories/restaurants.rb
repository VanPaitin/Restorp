FactoryBot.define do
  factory :restaurant do
    city nil
    is_active false
    name "MyString"
    description "MyString"
    logo "MyString"
    rating 1
    review_number 1
    address "MyString"
    post_code 1
    latitude 1.5
    longitude 1.5
    is_delivery_enabled false
    is_pickup_enabled false
    is_preorder_enabled false
    web_path "MyString"
    url_key "MyString"
    is_new false
    schedules ""
  end
end
