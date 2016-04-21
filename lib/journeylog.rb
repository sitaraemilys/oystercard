require_relative 'journey'

class JourneyLog

  attr_reader :history, :exit_station, :current_journey

  def initialize
     @history = []
  end

  def get_current_journey
    @current_journey.dup
  end

  def start(entry_station=nil, exit_station=nil)
    @current_journey = Journey.new(entry_station, exit_station) # current does not have anything in it
    @exit_station = nil
  end

  def end(exit_station)
    current_journey.end(exit_station)
    @exit_station = exit_station
    log
    reset
  end

  def reset
    @current_journey = nil
  end

  def log
    @history << current_journey.current
  end

  # def complete?
  #   @entry_station == nil && @exit_station == nil
  # end

  private



end
