module SearchName
  extend ActiveSupport::Concern

  included do
    scope :search_by, ->(query_term) { where('name ILIKE ?', "%#{query_term}%") }
  end
end
