class City < ApplicationRecord
  has_many :restaurants
  has_many :meals, through: :restaurants

  validates_uniqueness_of :name

  include SearchName
end
