require_relative 'journey'

class JourneyLog

  attr_reader :history

  def initialize
     @history = []
  end

  def get_current_journey
    @current_journey.current.dup
  end

  def start(entry_station)
    @current_journey = Journey.new(entry_station)
  end

  def end(exit_station)
    current_journey.end(exit_station)
    @history << current_journey.current
  end

  private

  attr_reader :current_journey


end
