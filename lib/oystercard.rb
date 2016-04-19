class Oystercard

  INITIAL_BALANCE = 0
  MIN_FARE = 1
  MAX_BALANCE = 90
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"
  MIN_BAL_ERR = "Minimum balance is £#{MIN_FARE}"

  attr_reader :balance

  def initialize
    @balance = INITIAL_BALANCE
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def touch_in
    raise MIN_BAL_ERR if insufficient_funds?
    @in_journey = true
  end

  def touch_out
    @in_journey = false
    deduct MIN_FARE
  end

  private
  def top_up_too_large? amount
    (balance + amount) > MAX_BALANCE
  end

  def insufficient_funds?
    balance < MIN_FARE
  end

  def deduct amount
    @balance -= amount
  end

end
