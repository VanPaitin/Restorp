class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!

  def show

  end

  def create
    order = current_user.orders.new(order_params)
    binding.pry
    if order.save
      render json: order
    else
      render json: order.errors
    end
  end

  private

  def order_params
    params.permit(meal_orders_attributes: [:meal_id, :quantity])
  end
end
