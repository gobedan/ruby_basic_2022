require_relative 'train.rb'

class PassengerTrain < Train

  def initialize(id)
    super
  end

  def type
    :passenger
  end
end