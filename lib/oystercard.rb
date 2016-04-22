require_relative 'journey'

class OysterCard

  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE = 2

  attr_reader :balance, :journey_history, :journey

  def initialize(balance = DEFAULT_BALANCE)
    @balance = balance
    @journey_history = []
    @journey = Journey.new
  end

  def top_up(amount)
    fail "New balance exceeds #{MAXIMUM_BALANCE}!" if limit_exceeded?(amount)
    @balance += amount
  end

  def touch_in(station)
    fail "Insufficient balance!" if insufficient_balance?
    no_touch_out
    @journey.start(station)
  end

  def touch_out(station)
    no_touch_in
    @journey.finish(station)
    log
    reset
  end

  private

  def no_touch_out
    if @journey.current_journey != {}
      deduct
      @journey.current_journey[:exit_station] = nil
      log
      reset
    end
  end

  def no_touch_in
    if @current_journey == nil
      deduct
      @journey.current_journey[:entry_station] = nil
      reset
    end
  end

  def log
    @journey_history << @journey.current_journey
  end

  def reset
    @journey.current_journey = {}
  end

  def limit_exceeded?(amount)
    @balance + amount > MAXIMUM_BALANCE
  end

  def insufficient_balance?
    @balance < MINIMUM_BALANCE
  end

  def deduct
    @balance -= @journey.fare
  end

end
