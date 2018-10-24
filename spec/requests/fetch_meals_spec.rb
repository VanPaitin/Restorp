require 'rails_helper'
require 'support/not_found'
require 'support/successful_response'

RSpec.describe "FetchMeals", type: :request do
  context "when the necessary query parameters are absent" do
    before { get api_v1_meals_path }

    it { expect(response).to have_http_status(422) }

    it { expect(json(response.body)).to have_key(:invalid) }
  end

  context "when the necessary query parameters are present" do
    context "when no cities or meals match" do
      before { get api_v1_meals_path, params: { city_id: 1, query: "meal" } }

      it_should_behave_like 'a 404 response'
    end

    context "when there are meals that match" do
      let(:meal) { create(:meal) }

      before { get api_v1_meals_path, params: { city_id: meal.restaurant.city.id, query: meal.name } }

      it "returns the meals that match the name" do
        expect(json(response.body)[:data][0][:name]).to eq meal.name
      end

      it_should_behave_like 'a successful response'
    end
  end
end
