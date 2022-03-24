class Train
  attr_reader :speed, :carriages_count, :type

  def initialize(id, type, carriages_count)
    @id = id
    @type = type
    @carriages_count = carriages_count
    @speed = 0
    @location = 0
  end

  def speedup
    @speed += 10
  end

  def stop 
    @speed = 0
  end
  
  def add_carriage
    @carriages_count += 1 if @speed == 0
  end

  def remove_carriage
    @carriages_count -= 1 if @speed == 0
  end

  def route=(route)
    @route = route 
    route.stations.first.accept(self)
  end

  #стремно выглядит управление состоянием станции из объекта поезда. 
  def go_forward
    if next_station
      current_station.depart(self)
      next_station.accept(self)
      @location += 1 
    end
  end

  def go_back
    if previous_station
      current_station.depart(self)
      previous_station.accept(self)
      @location -= 1
    end
  end

  # если удалить промежуточную станцию в маршруте, то списки поездов на станциях перестанут соответствовать реальности
  def next_station
    @route.stations[@location + 1]
  end

  def current_station
    @route.stations[@location]
  end

  def previous_station
    @route.stations[@location - 1] if @location > 0
  end 
end