class Meal < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cuisine
end
