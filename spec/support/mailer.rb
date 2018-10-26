RSpec.shared_examples 'A well-working mailer' do
  let(:user) { create(:user) }
  let(:order) { create(:order, user: user) }
  let(:mail) { OrderMailer.with(user: user, tracking_id: order.tracking_id).send(mailer_view) }

  it { expect(mail.subject).to eql mailer_subject }

  it { expect(mail.from).to eql ['restaurants@restorp.com'] }

  it { expect(mail.to).to eql [user.email] }

  it { expect { api_v1_order_url(order.tracking_id) }.not_to raise_error }

  it { expect(mail.body.encoded).to match(api_v1_order_url(order.tracking_id)) }

  it { expect(mail.body.encoded).to match(mailer_body) }
end
