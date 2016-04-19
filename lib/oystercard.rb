class Oystercard

  INITIAL_BALANCE = 0
  MAX_BALANCE = 90
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"

  attr_reader :balance

  def initialize
    @balance = INITIAL_BALANCE
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def deduct amount
    @balance -= amount
  end

  private
  def top_up_too_large? amount
    (balance + amount) > MAX_BALANCE
  end
end