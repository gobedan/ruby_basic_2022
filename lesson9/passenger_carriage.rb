# frozen_string_literal: true

require_relative 'carriage'

class PassengerCarriage < Carriage
  attr_reader :seats, :free_seats

  def initialize(seats)
    super
    @free_seats = @seats = seats
  end

  def take_seat
    @free_seats -= 1 if @free_seats.positive?
  end

  def occupied_seats
    seats - free_seats
  end

  def type
    :passenger
  end
end
