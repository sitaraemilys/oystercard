require 'oystercard'

describe OysterCard do
  let(:station) { double :station }
  let(:entry_station) { double :station }
  let(:exit_station) { double :station }
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}
  let(:maximum_balance_error) { "New balance exceeds #{OysterCard::MAXIMUM_BALANCE}!" }
  let(:minimum_balance_error) { "Insufficient balance!" }


  describe "initialize" do

    it 'sets balance to DEFAULT_BALANCE if not otherwise specified' do
      expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
    end

    it 'is creates a new journey' do
      expect(subject.journey).to be_a Journey
    end
  end

  describe '#top_up' do
    it 'changes balance with top up amount' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end
      context 'exceeds MAXIMUM_BALANCE' do
        it 'raises an error' do
          expect{ subject.top_up 100 }.to raise_error maximum_balance_error
        end
      end
  end

  describe '#touch_in' do
    context 'less than MINIMUM_BALANCE' do
      it 'raises an error' do
        expect{ subject.touch_in(station) }.to raise_error minimum_balance_error
      end
    end
  end

  describe '#touch_out' do
    it 'should deduct the fare from the balance' do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change { subject.balance }.by -OysterCard::MINIMUM_FARE
    end
  end

  describe '#journey_history' do
    it 'records a single journey in journeys' do
      subject.top_up(10)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journey_history).to include journey
    end
  end

end
