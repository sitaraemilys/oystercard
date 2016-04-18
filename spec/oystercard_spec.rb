require 'oystercard'

describe OysterCard do

  it 'sets balance to DEFAULT_BALANCE if not otherwise specified' do
    expect(subject.balance).to eq OysterCard::DEFAULT_BALANCE
  end

  describe '#top_up method' do

    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'changes balance with top up amount' do
      expect{ subject.top_up 50 }.to change{ subject.balance }.by 50
    end

    it 'raises an error if new balance would exceed MAXIMUM' do
      message = "New balance exceeds #{OysterCard::MAXIMUM}!"
      expect{ subject.top_up 100 }.to raise_error message
    end

  end

end
