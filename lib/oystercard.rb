class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2


  attr_reader :balance, :entry_station

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM_BALANCE}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance!" if insufficient_balance?
    @entry_station = station
  end

  def touch_out
    deduct_fare(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    !!@entry_station
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

end
