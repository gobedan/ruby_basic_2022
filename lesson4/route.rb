class Route
  attr_reader :stations
  
  def initialize(departure, destination)
    @stations = [departure, destination]
  end

  def add(station)
    @stations.insert(1, station)
  end

  def remove(station)
    middle_stations = @stations[1..-2]
    middle_stations.delete(station)
    @stations = [@stations[0], middle_stations, @stations[-1]].compact
  end

  def show_stations
    @stations.each {|station| puts station.name}
  end
end