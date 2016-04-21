require_relative 'journey'
require_relative 'journeylog'

class OystercardSystem

  INITIAL_BALANCE = 0
  MIN_FARE = 1
  MAX_BALANCE = 90
  PENALTY_FARE = 6
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"
  MIN_BAL_ERR = "Minimum balance is £#{MIN_FARE}"

  attr_reader :balance, :journeylog

  def initialize
    @balance = INITIAL_BALANCE
    @journeylog = JourneyLog.new # we do not start a journey when we create a card
  end

  def in_journey?
    journey.in_journey?
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def touch_in entry_station
    no_touch_out
    @journeylog.start(entry_station)
  end

  def touch_out exit_station
    no_touch_in
    @journeylog.end(exit_station)
  end

  private
  def no_touch_in
    if @journeylog.current_journey == nil
      @journeylog.start(nil, @journeylog.exit_station)
      deduct
    end
  end

  def no_touch_out
    if @journeylog.current_journey != nil
      deduct
      @journeylog.reset
    end
  end

  def top_up_too_large? amount
    (balance + amount) > MAX_BALANCE
  end

  def insufficient_funds?
    balance < MIN_FARE
  end

  def deduct
    @balance -= @journeylog.current_journey.fare
  end


end
