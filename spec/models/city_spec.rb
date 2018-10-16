require 'rails_helper'
require 'support/name_search'

RSpec.describe City, type: :model do
  it { is_expected.to have_many(:restaurants) }

  it { is_expected.to validate_uniqueness_of(:name) }

  it_should_behave_like 'a name search'
end
