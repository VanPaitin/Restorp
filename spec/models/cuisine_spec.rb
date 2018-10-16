require 'rails_helper'

RSpec.describe Cuisine, type: :model do
  it { is_expected.to have_and_belong_to_many(:restaurants) }

  it { is_expected.to have_many(:meals) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it { is_expected.to validate_uniqueness_of(:url_key) }
end
