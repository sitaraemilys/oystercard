class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :journeys

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journeys = []
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM_BALANCE}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance!" if insufficient_balance?
    record_start_station(station)
  end

  def touch_out(station)
    deduct_fare(MINIMUM_FARE)
    record_end_station(station)
  end

  def in_journey?
    journeys.empty? ? false : journeys.last.length < 2
  end

  private

  def limit_exceeded?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def insufficient_balance?
    @balance < MINIMUM_BALANCE
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def record_start_station(station)
    @journeys << {:entry_station => station}
  end

  def record_end_station(station)
    @journeys.last[:exit_station] = station
  end

end
