require 'rails_helper'
require 'support/name_search'

RSpec.describe Meal, type: :model do
  it { is_expected.to belong_to(:restaurant) }

  it { is_expected.to belong_to(:cuisine) }

  it { expect(build(:meal)).to be_valid }

  it_should_behave_like 'a name search'
end
