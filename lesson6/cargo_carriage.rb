require_relative 'carriage.rb'

class CargoCarriage < Carriage
  attr_reader :type

  def type 
    :cargo
  end
end