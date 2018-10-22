class OrderSerializer < ActiveModel::Serializer
  attributes :tracking_id, :total_price, :status, :meals

  def total_price
    "₦ #{object.total_price}"
  end

  def meals
    ActiveModel::Serializer::CollectionSerializer.new(object.meal_orders.includes(meal: :cuisine))
  end
end

