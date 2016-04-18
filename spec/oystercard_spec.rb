require 'oystercard'

describe Oyster do

  it 'has a DEFAULT_BALANCE of 0' do
    expect(subject.balance).to eq 0
  end

end
