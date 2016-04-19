class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM = 90
  MINIMUM = 1

  attr_reader :balance#, :in_journey?

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  #  @touched_in = false
  #  @touched_out = false
    @in_journey = false
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def touch_in
    fail "Insufficient balance!" if insufficient_balance?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  private

  def limit_exceeded?(amount)
    @balance + amount > MAXIMUM
  end

  def insufficient_balance?
    @balance < MINIMUM
  end

end
