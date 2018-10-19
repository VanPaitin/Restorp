class Order < ApplicationRecord
  belongs_to :user
  has_many :meal_orders
  has_many :meals, through: :meal_orders

  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :status,
            inclusion: { in: %w(pending processing ready delivered), message: "%{value} is not a valid status" }

  has_secure_token :tracking_id

  accepts_nested_attributes_for :meal_orders

  before_save :populate_total_price

  private

  def populate_total_price
    self.total_price = meal_orders.map(&:total_price).reduce(:+)
  end
end
