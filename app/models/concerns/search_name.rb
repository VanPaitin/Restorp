module SearchName
  extend ActiveSupport::Concern

  included do
    scope :search_by, ->(query_term) { where("#{self.name.underscore.pluralize}.name ILIKE ?", "%#{query_term}%") }
  end
end
