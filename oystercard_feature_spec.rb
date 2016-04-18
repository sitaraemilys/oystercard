require "./lib/oystercard.rb"

describe Oystercard do
  subject(:card) { Oystercard.new }

  context "checking an initial balance" do
    it "is created with a balance of zero" do
      expect(card.balance).to eq Oystercard::INITIAL_BALANCE
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
        expect{ card.top_up(100) }.to raise_error Oystercard::MAX_BAL_ERR
        card.top_up(45)
        expect{ card.top_up(46) }.to raise_error Oystercard::MAX_BAL_ERR
      end
    end
  end
end