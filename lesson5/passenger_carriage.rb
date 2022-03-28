require_relative 'carriage.rb'

class PassengerCarriage < Carriage
  attr_reader :type 

  def type 
    :passenger
  end 
end