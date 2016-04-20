require 'journey'

describe Journey do

  subject {described_class.new('Bond Street')}

  describe '#initialize' do

    it 'record an entry station' do
      expect(subject.entry).to eq true
    end

    it 'should store entry stations' do
      expect(subject.trip).to eq({:entry_station => 'Bond Street'})
    end
  end
end
