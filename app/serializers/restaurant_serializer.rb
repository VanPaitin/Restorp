class RestaurantSerializer < ActiveModel::Serializer
  attributes Restaurant.column_names.map(&:to_sym)
  attributes :meals

  has_many :cuisines

  def meals
    object.meals.map do |meal|
      serialized_meal = meal.as_json
      serialized_meal['cuisine'] = (object.cuisines.find { |cuisine| meal.cuisine_id == cuisine.id }).name
      serialized_meal
    end
  end
end
