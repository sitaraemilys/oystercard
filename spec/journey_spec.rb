require 'journey'

describe Journey do

  let(:entry_station){double(:entry_station)}
  let(:exit_station){double(:exit_station)}

  describe '#initialize' do

    it "should create an empty 'current_journey' hash" do
      expect(subject.current_journey).to eq ({})
    end

  end

  describe "#start" do

    it "should store the entry station in @current_journey" do
      subject.start(entry_station)
      expect(subject.current_journey).to include ({:entry_station => entry_station})
    end


  end

  describe "#finish" do

    it { is_expected.to respond_to(:finish).with(1).argument }

    it "should store the exit station in @current_journey" do
      subject.finish(exit_station)
      expect(subject.current_journey).to include ({:exit_station => exit_station})
    end

  end

  describe "#complete?" do

    it "should return true for a complete journey" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.complete?).to eq true
    end

    it "should return false if there's no exit station" do
      subject.start(entry_station)
      expect(subject.complete?).to eq false
    end

    it "should return false if there's no exit station" do
      subject.finish(entry_station)
      expect(subject.complete?).to eq false
    end

  end

  describe "#fare" do
    it "charges minimum fare for a complete journey" do
      subject.start(entry_station)
      subject.finish(exit_station)
      expect(subject.fare).to eq described_class::MINIMUM_FARE
    end

    it "charges penalty fare for an incomplete journey" do
      subject.finish(exit_station)
      expect(subject.fare).to eq described_class::PENALTY_FARE
    end

  end

end
