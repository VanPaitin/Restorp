FactoryBot.define do
  factory :city do
    name { Faker::Address.city }
    url_key { name.gsub(/\s/, '').dasherize }

    factory :city_with_restaurants do
      after(:create) do |city|
        create_list(:restaurant, 2, city: city)
      end
    end
  end
end
