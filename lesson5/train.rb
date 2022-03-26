class Train
  attr_reader :speed, :carriages

  def initialize(id)
    @id = id
    @speed = 0
    @location = 0
    @carriages = []
  end

  def speedup
    @speed += 10
  end

  def stop 
    @speed = 0
  end
  
  def add_carriage(carriage)
    carriages << carriage
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
    @route.stations[@location]
  end
  
  def next_station
    @route.stations[@location + 1]
  end

  def previous_station
    @route.stations[@location - 1] if @location > 0
  end 
end