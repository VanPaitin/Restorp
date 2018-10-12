class MealSerializer < ActiveModel::Serializer
  attributes Meal.column_names.map(&:to_sym)
  attributes :cuisine

  def cuisine
    object.cuisine_name
  end
end
