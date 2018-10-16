class Meal < ApplicationRecord
  belongs_to :restaurant
  belongs_to :cuisine

  include SearchName

  def cuisine_name
    cuisine.name
  end
end
