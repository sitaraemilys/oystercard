require 'journey'
describe Journey do
  let(:entry_station) { double :station }
  subject(:journey) { described_class.new(entry_station) }
  let(:max_balance_card) { double :max_balance_card, balance: 90 }
  let(:min_balance_card) { double :min_balance_card, balance: 1 }
  let(:exit_station) { double :station }


  describe '#initialize' do
    it 'has an empty current (journey)' do
        expect(journey.current).to be_empty
    end

    it 'has an entry station' do
      journey = Journey.new(entry_station)
      expect(journey.entry_station).to eq entry_station
    end
  end


  describe '#end' do
    before {journey.end(exit_station)}

    # it 'ends journey' do
    #   expect(journey.in_journey?).to eq false
    # end

    it 'creates and sets an exit station' do
      expect(journey.exit_station).to eq(exit_station)
    end

    it 'adds entry and exit station to current (journey) as a hash' do
      expect(journey.current).to eq({entry_station => exit_station})
    end
  end

  describe "#fare" do

    it "returns minimum fare if touched in and touched out" do
      journey.end(exit_station)
      expect(journey.fare).to eq described_class::MIN_FARE
    end

    it "returns penalty fare if no entry station" do
      journey.end(exit_station)
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end

    it "returns penalty fare if no exit station" do
      journey.start(entry_station)
      journey.start(entry_station)
      expect(journey.fare).to eq described_class::PENALTY_FARE
    end
  end

  describe '#complete?' do
    it "will return false if entry station has a value i.e. hasn't been reset" do
      allow(journey).to receive(:entry_station).and_return entry_station
      expect(journey.complete?).to eq false
    end

    it "will return false if exit station has a value i.e. hasn't been reset" do
      allow(journey).to receive(:exit_station).and_return(exit_station)
      expect(journey.complete?).to eq false
    end
  end


end
