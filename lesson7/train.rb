class Train
  include Nameable, Countable

  attr_reader :speed, :carriages, :id, :route, :type

  @@all_trains = [] 

  NAMING_PATTERN = /^[a-z0-9]{3}[-]?[a-z0-9]{2}$/i

  def self.find(id)
    @@all_trains.find { _1.id == id }
  end

  def initialize(id)
    @id = id
    @speed = 0
    @location = 0
    @carriages = []
    validate!
    @@all_trains << self
    register_instance
  end

  def speedup
    @speed += 10
  end

  def stop 
    @speed = 0
  end
  
  def add_carriage(carriage)
    carriages << carriage if type == carriage.type
  end

  def remove_carriage
    carriages.pop
  end

  def route=(route)
    @route = route 
    route.stations.first.accept(self)
  end

  def go_forward
    return unless next_station
    current_station.depart(self)
    next_station.accept(self)
    @location += 1 
  end

  def go_back
    return unless previous_station
    current_station.depart(self)
    previous_station.accept(self)
    @location -= 1
  end

  def current_station
    @route.stations[@location] if @route
  end
  
  def next_station
    @route.stations[@location + 1] if @route
  end

  def previous_station
    @route.stations[@location - 1] if @route && @location > 0
  end
  
  def valid?  
    validate!
    true
  rescue
    false
  end

  private 

  def validate! 
    raise StandardError.new("Wrong train identifier pattern! Should be: xxx-xx") unless id.match?(NAMING_PATTERN) 
  end
end