require_relative 'train.rb'

class CargoTrain < Train

  def initialize(id)
    super
  end

  def type 
    :cargo
  end
end