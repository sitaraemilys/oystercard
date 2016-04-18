require "./lib/oystercard.rb"

describe Oystercard do
  subject(:card) { Oystercard.new }

  context "checking an initial balance" do
    it "is created with a balance of zero" do
      expect(card.balance).to eq 0
    end
  end

  describe "topping up" do
    it "adds the specified top up value" do
      card.top_up(10)
      expect(card.balance).to eq 10
      card.top_up(12)
      expect(card.balance).to eq 22
    end
  end
end