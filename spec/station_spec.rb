require 'station'

describe Station do

  subject {described_class.new("hoxton", 1)}

    describe "#initialize" do

    it "should set the zone" do
      expect(subject.zone).to eq 1
    end

    it "should set the name" do
      expect(subject.name).to eq "hoxton"
    end

  end
end