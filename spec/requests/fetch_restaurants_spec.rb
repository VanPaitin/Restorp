require 'rails_helper'
require 'support/successful_response'
require 'support/not_found'

RSpec.describe "FetchRestaurants", type: :request do
  context "when there are no restaurants" do
    before { get api_v1_restaurants_path }

    it_behaves_like "a 404 response"
  end

  context "when there are restaurants" do
    let!(:restaurant1) { create(:restaurant) }
    let!(:restaurant2) { create(:restaurant) }
    let(:cuisine) { create(:cuisine) }
    let!(:restaurant3) do
      restaurant = create(:restaurant)
      restaurant.cuisines << cuisine
      restaurant
    end

    describe "a successful response" do
      before { get api_v1_restaurants_path }

      it_behaves_like 'a successful response'
    end

    context "when there are no query parameters" do
      before { get api_v1_restaurants_path }

      it "returns all the restaurants" do
        expect(json(response.body)[:data].count).to eql 3
      end
    end

    context "when there are query parameters" do
      context "when we search restaurants by city" do
        describe "the data returned" do
          before { get api_v1_restaurants_path, params: { city_id: restaurant1.city.id } }

          it { expect(json(response.body)[:data].count).to eql 1 }

          it "returns only restaurants found in the city" do
            expect(json(response.body)[:data][0][:name]).to eq restaurant1.name
          end
        end

        it "should call the by_city method" do
          expect(Restaurant).to receive(:by_city).with("#{restaurant1.city.id}").and_return([])
          expect(Restaurant).to_not receive(:search_by)

          get api_v1_restaurants_path, params: { city_id: restaurant1.city.id }
        end
      end

      context "when we search restaurants by name" do
        describe "the data returned" do
          before { get api_v1_restaurants_path, params: { query: restaurant2.name } }

          it { expect(json(response.body)[:data].count).to eql 1 }

          it "returns only restaurants that matches the name" do
            expect(json(response.body)[:data][0][:name]).to eq restaurant2.name
          end
        end

        it "should call the search_by method" do
          expect(Restaurant).to receive(:search_by).with(restaurant2.name).and_return([])
          expect(Restaurant).to_not receive(:by_city)

          get api_v1_restaurants_path, params: { query: restaurant2.name }
        end
      end

      context "when we search restaurants by cuisine" do
        describe "the data returned" do
          before { get api_v1_restaurants_path, params: { cuisine_ids: [cuisine.id] } }

          it { expect(json(response.body)[:data].count).to eql 1 }

          it "returns only restaurants that matches the name" do
            expect(json(response.body)[:data][0][:cuisines][0][:name]).to eq cuisine.name
          end
        end

        it "should call the search_by method" do
          expect(Restaurant).to receive(:by_cuisines).and_return([])
          expect(Restaurant).to_not receive(:by_city)
          expect(Restaurant).to_not receive(:search_by)

          get api_v1_restaurants_path, params: { cuisine_ids: [cuisine.id] }
        end
      end

      context "when we search by more than one query parameter" do
        it "should call the respective scopes" do
          expect(Restaurant).to receive(:by_city).and_return(Restaurant.unscoped)
          expect(Restaurant).to receive(:search_by).and_return([])
          expect(Restaurant).to_not receive(:by_cuisines)

          get api_v1_restaurants_path, params: { query: "lorem", city_id: 1 }
        end
      end
    end
  end
end
