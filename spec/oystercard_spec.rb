require 'oystercard'

describe OysterCard do
  let(:station){double :station}
  let(:entry_station){double :station}
  let(:exit_station){double :station}
  let(:journey){{entry_station: entry_station, exit_station: exit_station}}

  it 'sets balance to DEFAULT_BALANCE if not otherwise specified' do
    expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
  end

  describe '#top_up' do

    it 'changes balance with top up amount' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end

    it 'raises an error if new balance would exceed MAXIMUM_BALANCE' do
      message = "New balance exceeds #{OysterCard::MAXIMUM_BALANCE}!"
      expect{ subject.top_up 100 }.to raise_error message
    end

  end

  describe '#touch_in' do
    it 'sets #in_journey to true' do
      allow(subject).to receive(:insufficient_balance?).and_return false
      subject.touch_in(station)
      expect(subject.in_journey?).to be true
    end

    it 'fails if balance is less than MINIMUM_BALANCE' do
      message = "Insufficient balance!"
      expect{ subject.touch_in(station) }.to raise_error message
    end

    it { is_expected.to respond_to(:touch_in).with(1).argument }

  end

  describe '#touch_out(station)' do

    it { is_expected.to respond_to(:touch_out).with(1).argument }


    it 'sets #in_journey to false' do
      allow(subject).to receive(:insufficient_balance?).and_return false
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.in_journey?).to be false
    end

    it 'should deduct the fare from the balance' do
      subject.top_up(10)
      subject.touch_in(station)
      expect{ subject.touch_out(station) }.to change { subject.balance }.by -OysterCard::MINIMUM_FARE
    end

  end

  describe '#in_journey' do

    it 'sets to false on initialize' do
      expect(subject.in_journey?).to be false
    end

  end

  it { expect(subject.journeys).to be_empty }

  it 'records a single journey in journeys' do
    subject.top_up(10)
    subject.touch_in(entry_station)
    subject.touch_out(exit_station)
    expect(subject.journeys).to include journey
  end

end
