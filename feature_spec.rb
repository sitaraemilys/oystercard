require "./lib/oystercard.rb"
require "./lib/station.rb"

# fail "new oyster doesn't have £0 on it" unless oyster.balance == 0
#
# # In order to keep using public transport
# # As a customer
# # I want to add money to my card
# # oyster.top_up(6)
# # fail "oyster did not top up" unless oyster.balance == @balance
#
# # In order to protect my money from theft or loss
# # As a customer
# # I want a maximum limit (of £90) on my card
#
# oyster.top_up(85)
# # fail "topped up over limit" if oyster.balance > 90
#
# # In order to pay for my journey
# # As a customer
# # I need my fare deducted from my card
#  oyster.deduct(6)
#  fail "did not deduct £6" unless oyster.balance == (balance - 6)
# fail "new oyster doesn't have £0 on it" unless oyster.balance == 0

# In order to keep using public transport
# As a customer
# I want to add money to my card
# oyster.top_up(6)
# fail "oyster did not top up" unless oyster.balance == @balance

# In order to protect my money from theft or loss
# As a customer
# I want a maximum limit (of £90) on my card

#oyster.top_up(85)
# fail "topped up over limit" if oyster.balance > 90

# In order to pay for my journey
# As a customer
# I need my fare deducted from my card
# oyster.deduct(6)
 #fail "did not deduct £6" unless oyster.balance == (balance - 6)

 #  In order to pay for my journey
# As a customer
# I need to have the minimum amount (£1) for a single journey.
# oyster.deduct(79)
# oyster.touch_in
# fail "did not touch in" unless oyster.balance > 1

# oyster.touch_out
# fail "did not reduce fare" unless oyster.balance -= minimum fare


# In order to pay for my journey
# As a customer
# I need to know where I've travelled from

# oyster = Oystercard.new
# station = Station.new
# oyster.top_up(50)
# oyster.touch_in(station)
#fail "did not record original station" unless oyster.travelled_from == station

# In order to know where I have been
# As a customer
# I want to see to all my previous trips

# oyster = Oystercard.new
# station = Station.new
# station2 = Station.new
# oyster.top_up(50)
# oyster.touch_in(station)
# oyster.touch_out(station2)
# fail "doesn't return history" unless oyster.history == [station, station2]

# In order to be charged correctly
# As a customer
# I need a penalty charge deducted if I fail to touch in or out
