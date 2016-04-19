class Station

  def initialize(name, zone)
    @zone = zone
    @name = name
  end

  attr_reader :zone

  def name
    @name.dup
  end

end
