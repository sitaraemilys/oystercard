require "oystercard"

describe Oystercard do
  subject(:oystercard) { described_class.new }

  it "has a starting balance of zero" do
    expect(oystercard.balance).to eq Oystercard::INITIAL_BALANCE
  end

  describe "#top_up" do

    context "adding a valid amount" do
      let(:amount) { rand(Oystercard::MAX_BALANCE) }
      it "tops up the balance with the specified amount" do
        oystercard.top_up(amount)
        expect(oystercard.balance).to eq amount
      end
    end

    context "exceeding the maximum balance" do
      before { oystercard.top_up Oystercard::MAX_BALANCE }
      it "raises an error" do
        expect{ oystercard.top_up 1 }.to raise_error Oystercard::MAX_BAL_ERR
      end
      it "does not top up the balance" do
        begin
          oystercard.top_up 1
        rescue
          expect(oystercard.balance).to eq Oystercard::MAX_BALANCE
        end
      end
    end
  end
end