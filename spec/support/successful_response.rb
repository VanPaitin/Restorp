RSpec.shared_examples 'a successful response' do
  it { expect(response).to have_http_status(200) }
end
