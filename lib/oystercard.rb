require_relative 'journey'

class OystercardSystem

  INITIAL_BALANCE = 0
  MIN_FARE = 1
  MAX_BALANCE = 90
  PENALTY_FARE = 6
  MAX_BAL_ERR = "Maximum balance is £#{MAX_BALANCE}"
  MIN_BAL_ERR = "Minimum balance is £#{MIN_FARE}"

  attr_reader :balance, :journey

  def initialize
    @balance = INITIAL_BALANCE
    @journey = Journey.new # we do not start a journey when we create a card
  end

  def in_journey?
    journey.in_journey?
  end

  def top_up amount
    raise MAX_BAL_ERR if top_up_too_large? amount
    @balance += amount
  end

  def touch_in entry_station
    #raise "NO TOUCH OUT!" if @journey.history.include?(:start)
    raise MIN_BAL_ERR if insufficient_funds?
    @journey.start(entry_station)
    #current journey = Journey.new(entry_starion exit_station)
  end

  def touch_out exit_station
    deduct MIN_FARE
    @journey.end(exit_station)
    #current journey update
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

  # def entry_station_included?
  #   #if @journey.history
  # end

  # def penalty_fare?
  #   #journey_history.include?(:start)
  # end

end
