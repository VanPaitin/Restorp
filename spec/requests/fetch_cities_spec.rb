require 'rails_helper'
require 'support/not_found'
require 'support/successful_response'

RSpec.describe "FetchCities", type: :request do
  it "calls the search method" do
    expect(City).to receive(:search_by).with('query').and_return([])

    get api_v1_cities_path, params: { query: 'query' }
  end

  context "when there are no cities" do
    before { get api_v1_cities_path }

    it_behaves_like "a 404 response"
  end

  context "when there are cities" do
    before do
      create_list(:city, 2)
      get api_v1_cities_path
    end

    it_behaves_like "a successful response"
  end
end
