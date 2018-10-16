class Restaurant < ApplicationRecord
  belongs_to :city
  has_and_belongs_to_many :cuisines
  has_many :meals

  validates :name, presence: true, uniqueness: true

  include SearchName

  scope :by_city, ->(city_id) { where(city_id: city_id) }
  scope :by_cuisines, ->(cuisine_ids) do
    joins(
      "INNER JOIN cuisines_restaurants ON cuisines_restaurants.restaurant_id = restaurants.id"
    ).where('cuisines_restaurants.cuisine_id IN (?)', cuisine_ids).distinct
  end
end
