class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2


  attr_reader :balance#, :in_journey?

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  #  @touched_in = false
  #  @touched_out = false
    @in_journey = false
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM_BALANCE}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in
    fail "Insufficient balance!" if insufficient_balance?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct_fare(MINIMUM_FARE)
  end

  def in_journey?
    @in_journey
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
