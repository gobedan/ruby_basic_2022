require_relative 'carriage.rb'

class CargoCarriage < Carriage
  attr_reader :volume, :free_volume

  def initialize(volume)
    @free_volume = volume
    @volume = volume
  end

  def take_volume(size)
    @free_volume -= size if @free_volume >= size
  end

  def occupied_volume
    volume - free_volume
  end

  def type 
    :cargo
  end
end