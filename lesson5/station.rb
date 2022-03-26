class Station 
  attr_reader :name

  def initialize(name) 
    @name = name 
    @trains = [] 
  end

  def accept(train)
    @trains << train
  end

  def depart(train)
    @trains.delete(train)
  end

  # accepts :cargo or :passenger Symbol
  def trains(type = nil)
    type ? @trains.filter { |train| train.type == type } : @trains
  end
end