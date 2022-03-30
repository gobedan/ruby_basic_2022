# frozen_string_literal: true

require_relative 'carriage'

class CargoCarriage < Carriage
  attr_reader :volume, :free_volume

  def initialize(volume)
    super
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
