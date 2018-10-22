class MealOrderSerializer < ActiveModel::Serializer
  attributes :name, :description, :cuisine, :unit_price, :quantity, :total_price

  def unit_price
    object.price
  end

  def total_price
    "₦ #{object.total_price}"
  end

  def cuisine
    object.cuisine_name
  end
end
