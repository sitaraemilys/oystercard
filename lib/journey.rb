class Journey

attr_reader :history
MIN_FARE = 1
PENALTY_FARE = 6

  def initialize
    @history = {}
  end

  def in_journey?
    !(@history.has_key?(:end))
  end

  def start(entry_station)
    @history[:start] = entry_station
  end

  def end(exit_station)
    @history[:end] = exit_station
  end

  def fare
    history.has_key?(:start) && history.has_key?(:end) ? MIN_FARE : PENALTY_FARE
  end
end
