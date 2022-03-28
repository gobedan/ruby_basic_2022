class Station 
  include Countable
  
  attr_reader :name

  @@all_stations = []

  def self.all 
    @@all_stations
  end

  def initialize(name) 
    @name = name.to_s 
    @trains = [] 
    validate!
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

  def valid?  
    validate!
    true
  rescue
    false
  end

  private 

  def validate! 
    raise StandardError.new("Station name is too short!") if name.length < 2
  end
end