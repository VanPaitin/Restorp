RSpec.shared_examples 'name search' do
  it { expect(described_class).to respond_to(:search_by) }

  describe '.search_by' do
    factory_name = described_class.name.underscore
    let(:record1) { create(factory_name, name: 'matches') }
    let(:record2) { create(factory_name, name: 'no-match') }

    it 'returns only the results that match the query' do
      expect(described_class.search_by('matches')).to eq [record1]
    end
  end

end
