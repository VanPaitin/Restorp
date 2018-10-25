FactoryBot.define do
  factory :cuisine do
    sequence(:name) do |n|
      "Asian#{n}"
    end
    sequence(:url_key) do |n|
      "asian#{n}"
    end
  end
end
