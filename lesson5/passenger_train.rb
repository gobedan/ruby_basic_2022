class PassengerTrain < Train
  def initialize(id)
    super
  end

  def add_carriage(carriage)
    super if carriage.instance_of?(PassengerCarriage)
  end
end