class Oystercard

  INITIAL_BALANCE = 0
  MIN_FARE = 1
  MAX_BALANCE = 90
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"
  MIN_BAL_ERR = "Minimum balance is £#{MIN_FARE}"

  attr_reader :balance, :entry_station, :journey_history

  def initialize
    @balance = INITIAL_BALANCE
    @journey_history = []
  end

  def in_journey?
    !!entry_station
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def touch_in entry_station
    raise MIN_BAL_ERR if insufficient_funds?
    @entry_station = entry_station
  end

  def touch_out exit_station
    deduct MIN_FARE
    @journey_history << {entry_station => exit_station}
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
