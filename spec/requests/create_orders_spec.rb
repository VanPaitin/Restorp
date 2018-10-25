require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe "CreateOrders", type: :request do
  describe "POST create" do
    let(:user) { create(:user) }
    let!(:meal1) { create(:meal, number_in_stock: 2) }
    let!(:meal2) { create(:meal, number_in_stock: 1) }

    context "when user is not authenticated" do
      before { post api_v1_orders_path }

      it { expect(response).to have_http_status(401) }
    end

    context "when user is authenticated" do
      let(:headers) { { 'Accept' => 'application/json', 'Content-Type' => 'application/json' } }
      let(:auth_headers) { Devise::JWT::TestHelpers.auth_headers(headers, user) }

      context "when the requested meal has insufficient number in stock" do
        let(:params) do
          {
            meals: [
              { meal_id: meal1.id, quantity: 5 },
              { meal_id: meal2.id, quantity: 1 }
            ]
          }.to_json
        end
        let(:error_response) do
          [
            {
              params: { meal_id: meal1.id, quantity: 5 },
              error: { meal: ["There are no enough meals in stock"] }
            }
          ]
        end

        before { post api_v1_orders_path, params: params, headers: auth_headers }

        it { expect(response).to have_http_status(422) }

        it { expect(json(response.body)).to have_key(:errors) }

        it { expect(json(response.body)[:errors]).to eql error_response }
      end

      context "when all conditions are satisfied" do
        let(:params) do
          {
            meals: [
              { meal_id: meal1.id, quantity: 1 },
              { meal_id: meal2.id, quantity: 1 }
            ]
          }.to_json
        end
        let(:request) { proc { post api_v1_orders_path, params: params, headers: auth_headers } }

        it { expect(request).to change(Order, :count).by(1) }

        it { expect(request).to change(MealOrder, :count).by(2) }

        describe "meals stock numbers" do
          let(:meal1_id) { meal1.id }
          let(:meal2_id) { meal2.id }

          before { request.call }

          it "should reduce the ordered meals stock numbers" do
            expect(Meal.find(meal1_id).number_in_stock).to eql 1
            expect(Meal.find(meal2_id).number_in_stock).to eql 0
          end
        end

        describe "response" do
          before { request.call }

          it { expect(response).to have_http_status(201) }
        end
      end
    end
  end
end
