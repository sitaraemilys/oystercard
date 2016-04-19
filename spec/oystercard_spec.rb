require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }
  let(:entry_station) { double(:station) }
  let(:exit_station) { double(:station) }

  describe "#initialize" do
    it "has a starting balance" do
      expect(card.balance).to eq Oystercard::INITIAL_BALANCE
    end
    it "has an empty journey history" do
      expect(card.journey_history).to be_empty
    end
  end

  describe "#top_up" do
    context "adding a valid amount" do
      let(:amount) { rand(Oystercard::MAX_BALANCE) }
      it "tops up the balance with the specified amount" do
        card.top_up(amount)
        expect(card.balance).to eq amount
      end
    end

    context "exceeding the maximum balance" do
      before { card.top_up Oystercard::MAX_BALANCE }
      it "raises an error" do
        expect{ card.top_up 1 }.to raise_error Oystercard::MAX_BAL_ERR
      end
      it "does not top up the balance" do
        begin
          card.top_up 1
        rescue
          expect(card.balance).to eq Oystercard::MAX_BALANCE
        end
      end
    end
  end

  describe "#touch_in" do
    context "outside a journey" do
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

  describe "#touch_out" do
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
end
