require 'journeylog'

describe JourneyLog do

  subject(:journeylog) { described_class.new }

  describe '#initialize' do
    it "creates a new journey" do
      expect(journeylog.journey).to be_a Journey
    end
  end

end
