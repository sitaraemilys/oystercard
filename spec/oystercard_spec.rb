require 'oystercard'

describe OysterCard do

  it 'sets balance to DEFAULT_BALANCE if not otherwise specified' do
    expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
  end

  describe '#top_up' do

  #  it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes balance with top up amount' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end

    it 'raises an error if new balance would exceed MAXIMUM_BALANCE' do
      message = "New balance exceeds #{OysterCard::MAXIMUM_BALANCE}!"
      expect{ subject.top_up 100 }.to raise_error message
    end

  end

  # describe '#deduct_fare' do

  # #  it { is_expected.to respond_to(:deduct_fare).with(1).argument }

  #   it 'changes balance with deduct_fare amount' do
  #     subject.top_up(40)
  #     expect { subject.deduct_fare 20 }.to change { subject.balance }.by -20
  #  end

  # end

  describe '#touch_in' do
  #  before { allow(subject).to receive(:insufficient_balance?).and_return false }
  #  it { is_expected.to respond_to(:touch_in) }

    it 'sets #in_journey to true' do
      allow(subject).to receive(:insufficient_balance?).and_return false
      subject.touch_in
      expect(subject.in_journey?).to be true
    end

    it 'fails if balance is less than MINIMUM_BALANCE' do
      message = "Insufficient balance!"
      expect{ subject.touch_in }.to raise_error message
    end

  end

  describe '#touch_out' do

  #  it { is_expected.to respond_to(:touch_out) }

    it 'sets #in_journey to false' do
      allow(subject).to receive(:insufficient_balance?).and_return false
      subject.touch_in
      subject.touch_out
      expect(subject.in_journey?).to be false
    end

    it 'should deduct the fare from the balance' do
      subject.top_up(10)
      subject.touch_in
      expect{ subject.touch_out }.to change { subject.balance }.by -OysterCard::MINIMUM_FARE
    end
  end

  describe '#in_journey' do

    it 'sets to false on initialize' do
      expect(subject.in_journey?).to be false
    end

  end


end
