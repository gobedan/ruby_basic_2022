require_relative 'train.rb'

class CargoTrain < Train
  def initialize(id)
    super
  end

  def add_carriage(carriage)
    super if carriage.instance_of?(CargoCarriage)  
  end

  def type 
    :cargo
  end
end