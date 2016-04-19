require 'station'

describe Station do
  let(:zone){rand(5)}
  let(:station_name){(0...8).map { (65 + rand(26)).chr }.join}
  subject(:station) { described_class.new station_name, zone }

  describe "#zone" do
    it "returns the zone" do
      expect(station.zone).to eq zone
    end
  end

  describe "#name" do
    it "returns the name" do
      expect(station.name).to eq station_name
    end
  end


end
