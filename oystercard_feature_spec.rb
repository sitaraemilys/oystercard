require "./lib/oystercard.rb"
require "./lib/station.rb"

describe "Oystercard challenge" do
  let(:card) { Oystercard.new }
  let(:entry_station) { Station.new("Entry Station", 1) }
  let(:exit_station) { Station.new("Exit Station", 3) }

  context "a new card" do

    it "is created with an initial balance" do
      expect(card.balance).to eq Oystercard::INITIAL_BALANCE
    end

    it "has an empty journey history" do
      expect(card.journey_history).to be_empty
    end

  end

  describe "topping up" do
    it "adds the specified top up value" do
      card.top_up(10)
      expect(card.balance).to eq 10
      card.top_up(80)
      expect(card.balance).to eq 90
    end
    context "topping up to more than £#{Oystercard::MAX_BALANCE}" do
      it "throws an error" do
        expect { card.top_up(100) }.to raise_error Oystercard::MAX_BAL_ERR
        card.top_up(45)
        expect { card.top_up(46) }.to raise_error Oystercard::MAX_BAL_ERR
      end
    end
  end

  describe "touching in" do
    context "outside of a journey" do
      context "sufficient funds" do
        before { card.top_up Oystercard::MIN_FARE }
        it "starts a journey" do
          card.touch_in entry_station
          expect(card.in_journey?).to be_truthy
        end
        it "records the entry station" do
          card.touch_in entry_station
          expect(card.journey_history.last[:start]).to eq entry_station
        end
      end
      context "insufficient funds" do
        it "raises an error" do
          expect { card.touch_in entry_station }.to raise_error Oystercard::MIN_BAL_ERR
        end
      end
    end
  end

  describe "touching out" do
    context "during a journey" do
      before { card.top_up Oystercard::MIN_FARE; card.touch_in entry_station }
      let(:journey) { {:start => entry_station, :end => exit_station} }
      it "ends the journey" do
        card.touch_out exit_station
        expect(card.in_journey?).to be_falsey
      end
      it "deducts the balance by minimum fare" do
        expect { card.touch_out exit_station }.to change { card.balance }.by(-Oystercard::MIN_FARE)
      end
      it "adds the journey to the journey history" do
        card.touch_out exit_station
        expect(card.journey_history).to include journey
      end
    end
  end

  describe "finding station information" do
    it "finds the zone" do
      expect(entry_station.zone).to eq 1
      expect(exit_station.zone).to eq 3
    end
    it "finds the name" do
      expect(entry_station.name).to eq "Entry Station"
      expect(exit_station.name).to eq "Exit Station"
    end
  end

end
