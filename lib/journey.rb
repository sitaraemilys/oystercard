class Journey
  attr_reader :current_journey

  def initialize
    @current_journey = {}
    #@entry = (station != nil ? true : false)
  end

  def start(station)
    @current_journey[:entry_station] = station
  end

  def finish(station)
    @current_journey[:exit_station] = station
  end

  # def fare
  # end

  def complete?
    journey_started? && journey_ended?
  end

  private

  def journey_started?
    @current_journey.include?(:entry_station)
  end

  def journey_ended?
    @current_journey.include?(:exit_station)
  end

end
