require 'journey'
describe Journey do

  subject(:journey) { described_class.new }
  let(:max_balance_card) { double :max_balance_card, balance: 90 }
  let(:min_balance_card) { double :min_balance_card, balance: 1 }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }


  describe '#initialize' do
    it 'has an empty journey history' do
        expect(journey.history).to be_empty
    end
  end

  describe '#start' do
    before {journey.start(entry_station)}
    it 'stores an entry station' do
      expect(journey.history[:start]).to eq entry_station
    end
    it 'starts journey' do
      expect(journey.in_journey?).to eq true
    end

  end

  describe '#end' do
    before {journey.start(entry_station)}
    before {journey.end(exit_station)}
    it 'stores an exit station' do
      expect(journey.history[:end]).to eq exit_station

    end
    it 'ends journey' do
      expect(journey.in_journey?).to eq false
    end
  end

  describe "#fare" do

    it "returns minimum fare if touched in and touched out" do
      journey.start(entry_station)
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


end
