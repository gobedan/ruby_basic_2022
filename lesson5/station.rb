class Station 
  include Countable
  
  attr_reader :name

  @@all_stations = []

  def self.all 
    @@all_stations
  end

  def initialize(name) 
    @name = name 
    @trains = [] 
    @@all_stations << self
    register_instance
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