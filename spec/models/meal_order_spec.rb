require 'rails_helper'

RSpec.describe MealOrder, type: :model do
  it { is_expected.to belong_to(:meal) }

  it { is_expected.to belong_to(:order) }

  it { is_expected.to delegate_method(:price).to(:meal) }

  it { is_expected.to delegate_method(:name).to(:meal) }

  it { is_expected.to delegate_method(:description).to(:meal) }

  it { is_expected.to delegate_method(:cuisine_name).to(:meal) }

  describe "quantity validation" do
    subject { create(:meal_order) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than_or_equal_to(0) }
  end

  describe "insufficient meal stock validation" do
    let!(:meal) { create(:meal, number_in_stock: 1) }
    let(:invalid_meal_order) { build(:meal_order, quantity: 2, meal: meal) }
    let(:valid_meal_order) { build(:meal_order, quantity: 1, meal: meal) }

    it "should be invalid if the number of meals in stock is insufficient" do
      expect(invalid_meal_order).to be_invalid
      expect(invalid_meal_order.errors.messages.values).to include ["There are no enough meals in stock"]
    end

    it "should be valid if there is sufficient meal stock number" do
      expect(valid_meal_order).to be_valid
    end

    it "should reduce the meal stock on successful meal order create" do
      valid_meal_order.save

      expect(valid_meal_order.total_price).to eql(valid_meal_order.quantity * meal.price)
      expect(meal.number_in_stock).to eql 0
    end
  end
end
