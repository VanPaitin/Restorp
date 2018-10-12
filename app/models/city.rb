class City < ApplicationRecord
  has_many :areas

  validates_uniqueness_of :name
end
