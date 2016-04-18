require 'oystercard'

describe OysterCard do

  it 'sets balance to DEFAULT_BALANCE if not otherwise specified' do
    expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
  end

  describe '#top_up' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes balance with top up amount' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end

    it 'raises an error if new balance would exceed MAXIMUM' do
      message = "New balance exceeds #{OysterCard::MAXIMUM}!"
      expect{ subject.top_up 100 }.to raise_error message
    end

  end

  describe '#deduct_fare' do

    it { is_expected.to respond_to(:deduct_fare).with(1).argument }

    it 'changes balance with deduct_fare amount' do
      subject.top_up(40)
      expect { subject.deduct_fare 20 }.to change { subject.balance }.by -20
    end

  end

  describe '#touch_in' do

    it { is_expected.to respond_to(:touch_in) }

    it 'sets #in_journey to true' do
      subject.touch_in
      expect(subject.in_journey).to eq true
    end

  end

end
