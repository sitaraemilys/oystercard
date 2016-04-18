require "./lib/oystercard.rb"

describe Oystercard do
  subject(:card) { Oystercard.new }
  describe "checking a balance" do
    it "is created with a balance of zero" do
      expect(card.balance).to eq 0
    end
  end
end