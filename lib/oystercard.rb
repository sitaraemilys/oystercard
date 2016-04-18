class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM = 90

  attr_reader :balance, :in_journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @in_journey = false
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def deduct_fare(amount)
    @balance -= amount
  end

  def limit_exceeded?(amount)
    @balance + amount > MAXIMUM
  end

  def touch_in
    @in_journey = true
  end

end
