class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM = 90

  attr_reader :balance

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
  end

  def top_up(amount)
    @balance += amount
    fail "New balance exceeds #{MAXIMUM}!" if limit_exceeded?
  end

  def limit_exceeded?
    @balance + amount > MAXIMUM
  end

end
