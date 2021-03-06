# Exercise 5 Part 1 (Exception Handling)

class MentalState
  def auditable?
    # true if the external service is online, otherwise false
  end
  def audit!
    # Could fail if external service is offline
  end
  def do_work
    # Amazing stuff...
  end
end

class InvalidMentalStateException < ArgumentError; end

def audit_sanity(bedtime_mental_state)
  raise InvalidMentalStateException.new("External service is offline") unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

begin
  new_state = audit_sanity(bedtime_mental_state)
rescue InvalidMentalStateException => e
  puts e.message
else
  new_state = audit_sanity(bedtime_mental_state)
end





# Exercise 5 Part 2 (Don't Return Null / Null Object Pattern)

class BedtimeMentalState < MentalState ; end

class MorningMentalState < MentalState ; end

class NullAudit < MentalState

  def initialize
    puts "Unknown Service Status"
  end

def audit_sanity(bedtime_mental_state)
  return NullAudit.new unless bedtime_mental_state.auditable?
  if bedtime_mental_state.audit!.ok?
    MorningMentalState.new(:ok)
  else 
    MorningMentalState.new(:not_ok)
  end
end

new_state = audit_sanity(bedtime_mental_state)
new_state.do_work




# Exercise 5 Part 3 (Wrapping APIs)

require 'candy_service'

class MyCandyMachine
  machine = CandyMachine.new
  machine.prepare

  if machine.ready?
    machine.make!
  else
    puts "sadness"
  end
end