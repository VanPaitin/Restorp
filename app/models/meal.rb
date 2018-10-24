class Meal < ApplicationRecord
  belongs_to :cuisine
  belongs_to :restaurant

  include SearchName

  def cuisine_name
    cuisine.name
  end

  def as_json
    super.except('created_at', 'updated_at')
  end
end
