class CuisineSerializer < ActiveModel::Serializer
  attributes Cuisine.column_names.map(&:to_sym)
end
