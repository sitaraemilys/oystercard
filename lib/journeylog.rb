require_relative 'journey'

class JourneyLog

  attr_reader :history

  def initialize
     @history = []
  end

  def get_current_journey
    @current_journey.dup
  end

  def start(entry_station)
    @current_journey = Journey.new(entry_station) # current does not have anything in it
  end

  def end(exit_station)
    current_journey.end(exit_station)
    @history << current_journey.current
    @current_journey = nil # this needs to be moved to another method (reset), it is the last thing that end is returning
  end

  # def complete?
  #   @entry_station == nil && @exit_station == nil
  # end

  private

  attr_reader :current_journey


end
