class Cuisine < ApplicationRecord
  has_and_belongs_to_many :restaurants
  has_many :meals

  validates_uniqueness_of :name
  validates_uniqueness_of :url_key
end
