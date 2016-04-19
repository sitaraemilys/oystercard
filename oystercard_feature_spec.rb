require "./lib/oystercard.rb"

describe Oystercard do
  subject(:card) { Oystercard.new }

  context "a new card" do

    it "is created with a balance of zero" do
      expect(card.balance).to eq Oystercard::INITIAL_BALANCE
    end

    it { is_expected.not_to be_in_journey }
    
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

  describe "deducting money" do
    it "deducts the specified amount from the card" do
      expect { card.deduct 20 }.to change { card.balance }.by(-20)
      expect { card.deduct 50 }.to change { card.balance }.by(-50)
    end
  end

  describe "touching in" do
    context "outside of a journey" do
      it "starts a journey" do
        expect { card.touch_in }.to change { card.in_journey? }.from(false).to(true)
      end
    end
  end
  describe "touching out" do
    context "during a journey" do
      before { card.touch_in }
      it "ends the journey" do
        expect { card.touch_out }.to change { card.in_journey? }.from(true).to(false)
      end
    end
  end
end
