class Seat < ActiveRecord::Base
  belongs_to :flight
  def validate
    if baggage > flight.baggage_allowance
      errors.add_to_base("You have too much baggage")
    end
    if flight.seats.size >= flight.capacity
      errors.add_to_base("Sorry, this flight is already full")
    end
  end
end
