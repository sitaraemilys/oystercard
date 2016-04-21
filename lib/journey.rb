class Journey

attr_reader :current, :entry_station, :exit_station
MIN_FARE = 1
PENALTY_FARE = 6

  def initialize(entry_station=nil, exit_station=nil)
    @entry_station = entry_station
    @exit_station = exit_station
    @current = {}
  end

  # def in_journey?
  #   !(@history.has_key?(:end))
  # end

  def end(exit_station)
    @exit_station = exit_station
    @current[@entry_station] = @exit_station
  end

  def complete?
    @entry_station == nil && @exit_station == nil
  end

  def fare
   complete? ? MIN_FARE : PENALTY_FARE
  end
end
