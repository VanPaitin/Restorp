class City < ApplicationRecord
  has_many :restaurants

  validates_uniqueness_of :name
end
