class Meal < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cuisine

  def cuisine_name
    cuisine.name
  end
end
