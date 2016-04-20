class Journey
  attr_reader :trip, :entry

  def initialize(station=nil)
    @trip = {:entry_station => station}
    @entry = (station != nil ? true : false)
  end

  def finish
  end

  def fare
  end

  def complete?
  end

end
