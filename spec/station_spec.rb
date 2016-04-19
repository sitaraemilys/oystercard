require 'station'

describe Station do

  subject {described_class.new("Bond Street",1 )}

  it "should set zone" do
    station = Station.new(1)
    expect(station.zone).not_to be nil
  end
end