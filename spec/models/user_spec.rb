require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:orders) }

  it { is_expected.to validate_presence_of(:first_name) }
end
