require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it "has a starting balance of zero" do
    expect(oystercard.balance).to eq 0
  end
  describe "#top_up" do
    let(:amount) { rand(100) }
    it "tops up the balance with the specified amount" do
      oystercard.top_up(amount)
      expect(oystercard.balance).to eq amount
    end
  end
end