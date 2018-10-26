require "rails_helper"
require "support/mailer"

RSpec.describe OrderMailer, type: :mailer do
  describe "#order_confirmation" do
    let(:mailer_view) { 'order_confirmation' }
    let(:mailer_subject) { 'Order Confirmation' }
    let(:mailer_body) { 'You have successfully ordered' }

    it_behaves_like 'A well-working mailer'
  end

  describe "#order_status_update" do
    let(:mailer_view) { 'order_status_update' }
    let(:mailer_subject) { 'The status of your order has been updated' }
    let(:mailer_body) { 'the status of your order has been updated' }

    it_behaves_like 'A well-working mailer'
  end
end
