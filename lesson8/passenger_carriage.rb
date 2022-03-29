require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  attr_reader :seats, :free_seats

  def initialize(seats)
    @free_seats = @seats = seats 
  end

  def take_seat
    @free_seats -= 1 if @free_seats > 0 
  end

  def occupied_seats
    seats - free_seats
  end

  def type 
    :passenger
  end 
end