class Restaurant < ApplicationRecord
  belongs_to :city
  has_and_belongs_to_many :cuisines
  has_many :meals

  scope :by_city, ->(city_id) { where(city_id: city_id) }
  scope :search_by, ->(query_term) { where('name ILIKE ?', "%#{query_term}%") }
end
