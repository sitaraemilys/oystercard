class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :journey_history, :journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM_BALANCE}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance!" if insufficient_balance?
    @journey.start(station)
  end

  def touch_out(station)
    deduct_fare(MINIMUM_FARE)
    @journey.finish(station)
    @journey_history << @journey.current_journey
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
