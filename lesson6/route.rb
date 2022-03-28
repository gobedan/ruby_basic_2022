class Route
  include Countable 

  attr_reader :stations
  
  def initialize(departure, destination)
    @stations = [departure, destination]
    register_instance
  end

  def add(station)
    @stations.insert(1, station)
  end

  def remove(station)
    @stations.delete(station) unless [@stations.first, @stations.last].include?(station)
  end

  def show_stations
    result = "[ "
    @stations.each {|station| result += " #{station.name} "}
    result += " ]"
  end
end