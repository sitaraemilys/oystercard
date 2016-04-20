class Journey

attr_reader :history

  def initialize
    @history = []
  end

  def in_journey?
    !(@history.last.has_key?(:end))
  end

  def start(entry_station)
    @history << {:start => entry_station}
  end

  def end(exit_station)
    @history << {:end => exit_station}
  end

end
