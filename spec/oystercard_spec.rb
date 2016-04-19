require "oystercard"

describe Oystercard do
  subject(:card) { described_class.new }

  describe "#initialize" do

    it { is_expected.not_to be_in_journey }

    it "has a starting balance" do
      expect(card.balance).to eq Oystercard::INITIAL_BALANCE
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

  describe "#deduct" do

    let(:amount) { rand(20) }
    it "deducts the specified amount from the card" do
      expect { card.deduct amount }.to change{ card.balance }.by(-amount)
    end
  end

  describe "#touch_in" do

    context "outside a journey" do
      it "starts a journey" do
        expect { card.touch_in }.to change { card.in_journey? }.from(false).to(true)
      end
    end
  end

  describe "#touch_out" do

    context "during a journey" do
      before { card.touch_in }
      it "ends the journey" do
        expect { card.touch_out }.to change { card.in_journey? }.from(true).to(false)
      end
    end
  end









end
