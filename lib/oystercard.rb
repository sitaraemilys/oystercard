class Oystercard

  INITIAL_BALANCE = 0
  MIN_FARE = 1
  MAX_BALANCE = 90
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"
  MIN_BAL_ERR = "Minimum balance is £#{MIN_FARE}"

  attr_reader :balance, :entry_station

  def initialize
    @balance = INITIAL_BALANCE
  end

  def in_journey?
    !!entry_station
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def touch_in station
    raise MIN_BAL_ERR if insufficient_funds?
    @entry_station = station
  end

  def touch_out
    deduct MIN_FARE
    @entry_station = nil
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
