class Order < ApplicationRecord
  belongs_to :user
  has_many :meal_orders
  has_many :meals, through: :meal_orders

  validates :status,
            inclusion: { in: %w(pending processing ready delivered), message: "%{value} is not a valid status" }

  has_secure_token :tracking_id

  accepts_nested_attributes_for :meal_orders
end
