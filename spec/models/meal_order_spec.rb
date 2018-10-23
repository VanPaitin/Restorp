require 'rails_helper'

RSpec.describe MealOrder, type: :model do
  it { is_expected.to belong_to(:meal) }

  it { is_expected.to belong_to(:order) }
end
