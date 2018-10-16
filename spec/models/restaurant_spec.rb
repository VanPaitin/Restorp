require 'rails_helper'
require 'support/name_search'

RSpec.describe Restaurant, type: :model do
  it { is_expected.to belong_to(:city) }

  it { is_expected.to have_and_belong_to_many(:cuisines) }

  it { is_expected.to have_many(:meals) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to validate_uniqueness_of(:name)}

  it_behaves_like 'name search'

  describe '.by_city' do
    let(:city) { create(:city_with_restaurants) }
    let(:restaurant) { create(:restaurant) }
    let(:restaurants) { described_class.by_city(city.id) }

    it { expect(restaurants).to eq city.restaurants }

    it { expect(restaurants).to_not include restaurant }

    it { expect(restaurants.count).to eql 2 }
  end
end
