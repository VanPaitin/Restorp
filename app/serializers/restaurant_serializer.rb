class RestaurantSerializer < ActiveModel::Serializer
  attributes Restaurant.column_names.map(&:to_sym)
  has_many :cuisines
  has_many :meals
end
