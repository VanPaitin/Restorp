class Api::V1::OrdersController < ApplicationController
  before_action :authenticate_user!, except: :show

  def show
    order = Order.find_by_tracking_id(params[:id])

    render json: order
  end

  def create
    order = current_user.orders.new(meal_orders_attributes: order_params[:meals])
    order_service = OrderService.new(order: order, user: current_user)

    if order.valid?
      order_service.create_order
      render json: order, status: :created
    else
      render json: order_service.errors, status: 422
    end
  end

  def update
    order = Order.find(params[:id])

    if order.update(order_status_params)
      OrderMailer.with(user: order.user, tracking_id: order.tracking_id).order_status_update.deliver_later
      render json: order
    else
      render json: order.errors, status: 422
    end
  end

  private

  def order_params
    params.permit(meals: [:meal_id, :quantity])
  end

  def order_status_params
    params.permit(:status)
  end
end
