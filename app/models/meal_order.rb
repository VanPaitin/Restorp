class MealOrder < ApplicationRecord
  belongs_to :meal
  belongs_to :order

  delegate :price, to: :meal

  before_create :populate_total_price

  after_create :update_meal_stock

  private

  def populate_total_price
    return false unless quantity <= meal.number_in_stock
    self.total_price = quantity * price
  end

  def update_meal_stock
    meal.update_attribute :number_in_stock, (meal.number_in_stock - quantity)
  end
end
