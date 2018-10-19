require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to :user }

  it { is_expected.to validate_presence_of(:total_price) }

  it { is_expected.to validate_numericality_of(:total_price).is_greater_than_or_equal_to(0) }

  it { is_expected.to validate_inclusion_of(:status).in_array(%w(pending processing ready delivered)) }
end
