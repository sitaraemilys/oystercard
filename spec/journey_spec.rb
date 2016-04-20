require 'journey'

describe Journey do

  subject(:journey) { described_class.new }
  let(:max_balance_card) { double :max_balance_card, balance: 90 }
  let(:min_balance_card) { double :min_balance_card, balance: 1 }
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }


  describe '#initialize' do
    it 'has an empty journey history' do
        expect(journey.journey_history).to be_empty
    end

    it 'is not in a journey' do
      expect(journey.in_journey?).to eq false
    end
  end




  # describe '#touch_in' do
  #   context 'sufficient funds' do
  #     it 'starts a journey' do
  #       min_balance_card.touch_in(entry_station)
  #       expect
  #     end
  #   end



end


# describe "#touch_in" do
#   context "outside a journey" do
#     context "sufficient funds" do
#       before { card.top_up Oystercard::MIN_FARE }
#       it "starts a journey" do
#         card.touch_in entry_station
#         expect(card.in_journey?).to be_truthy
#       end
#       it "records the entry station" do
#         card.touch_in entry_station
#         expect(card.journey_history.last[:start]).to eq entry_station
#       end
#     end
