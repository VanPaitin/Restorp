class MealSerializer < ActiveModel::Serializer
  attributes Meal.column_names.map(&:to_sym) - %i(created_at updated_at)
  attributes :cuisine

  def cuisine
    object.cuisine_name
  end
end
