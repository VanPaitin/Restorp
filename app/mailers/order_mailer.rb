class OrderMailer < ApplicationMailer
  before_action :set_name_and_tracking_id
  default from: 'restaurants@restorp.com'

  def order_confirmation
    mail(to: @email, subject: 'Order Confirmation')
  end

  def order_status_update
    mail(to: @email, subject: 'The status of your order has been updated')
  end

  private

  def set_name_and_tracking_id
    user = params[:user]
    @email = user.email
    @name = user.first_name
    @tracking_id = params.fetch(:tracking_id)
  end
end
