require 'rails_helper'

RSpec.describe Order, type: :model do
  it { is_expected.to belong_to :user }

  it { is_expected.to have_many(:meal_orders) }

  it { is_expected.to have_many(:meals).through(:meal_orders) }

  it { is_expected.to validate_inclusion_of(:status).in_array(%w(pending processing ready delivered)) }

  it { is_expected.to accept_nested_attributes_for(:meal_orders) }
end
