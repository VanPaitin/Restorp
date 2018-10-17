RSpec.shared_examples "a 404 response" do
  it { expect(response).to have_http_status(404) }

  it { expect(json(response.body)).to have_key(:none) }
end
