require "oystercard"
describe Oystercard do
  subject(:oystercard) { described_class.new }

  it "has a starting balance of zero" do
    expect(oystercard.balance).to eq 0
  end
end