class OrderService
  def initialize(order:, user:)
    @order = order
    @user = user
  end

  def create_order
    order.total_price = order.meal_orders.map(&:total_price).reduce(:+)
    order.save
    OrderMailer.with(user: user, tracking_id: order.tracking_id).order_confirmation.deliver_later
  end

  def errors
    invalid_meals = order.meal_orders.select(&:invalid?)
    @erroneous_meals = []
    invalid_meals.each { |meal| @erroneous_meals << build_error_message(meal) }
    { errors: @erroneous_meals }
  end

  private

  attr_reader :order, :user

  def build_error_message(meal)
    { params: { meal_id: meal.meal_id, quantity: meal.quantity }, error: meal.errors }
  end
end
