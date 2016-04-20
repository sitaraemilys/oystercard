require_relative 'journey'

class JourneyLog

  attr_reader :journey

  def initialize(journey = Journey.new)
    @journey = journey
  end
end
