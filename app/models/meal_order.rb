class MealOrder < ApplicationRecord
  belongs_to :meal
  belongs_to :order

  delegate :price, :name, :description, :cuisine_name, to: :meal

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validate :ensure_meal_is_available

  before_validation :populate_total_price

  after_create :update_meal_stock

  private

  def populate_total_price
    self.total_price = quantity * price
  end

  def update_meal_stock
    meal.update_attribute :number_in_stock, (meal.number_in_stock - quantity)
  end

  def ensure_meal_is_available
    if quantity > meal.number_in_stock
      errors.add(:meal, "There are no enough meals in stock")
    end
  end
end
