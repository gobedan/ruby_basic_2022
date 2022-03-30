# frozen_string_literal: true

require_relative 'nameable'
require_relative 'countable'
require_relative 'cargo_carriage'
require_relative 'cargo_train'
require_relative 'carriage'
require_relative 'passenger_carriage'
require_relative 'passenger_train'
require_relative 'route'
require_relative 'station'
require_relative 'train'

class Main
  attr_reader :trains, :routes, :stations

  def initialize
    @trains = []
    @routes = []
    @stations = []
    seed
    main
  end

  private

  def seed
    @stations = [Station.new('Vasuki'), Station.new('Saratov'), Station.new('Kukuevo')]
    @routes = [Route.new(@stations.first, @stations[1]), Route.new(@stations[1], @stations.last)]
    @trains = [CargoTrain.new('001-fi'), PassengerTrain.new('002-se')]
    @trains[0].route = @routes[0]
    @trains[1].route = @routes[1]
    @trains[0].add_carriage(CargoCarriage.new(10))
    @trains[0].add_carriage(CargoCarriage.new(20))
    @trains[0].add_carriage(CargoCarriage.new(30))
    @trains[0].carriages.first.take_volume(5)
    @trains[1].add_carriage(PassengerCarriage.new(12))
    @trains[1].add_carriage(PassengerCarriage.new(24))
    @trains[1].carriages.last.take_seat
  end

  def main
    puts '== Train station =='

    loop do
      puts '-- Main menu --'
      puts 'choose action:'
      puts '1 - create (station, train or route)'
      puts '2 - edit route'
      puts '3 - control train'
      puts '4 - show all stations with trains'
      puts "type 'exit' to finish"

      command = gets.chomp

      case command
      when '1'
        creation_menu
      when '2'
        edit_route if @routes.any?
      when '3'
        control_train if @trains.any?
      when '4'
        station_list
      when 'exit'
        break
      else
        puts 'Wrong command! Try again!'
      end
    end
  end

  def creation_menu
    loop do
      puts '- Creation menu -'
      puts 'choose entity to create:'
      puts '1 - create station'
      puts '2 - create route'
      puts '3 - create cargo train'
      puts '4 - create passenger train'
      puts "type 'back' to go back"

      command = gets.chomp

      case command
      when '1'
        create_station
      when '2'
        create_route
      when '3'
        create_cargo_train
      when '4'
        create_passenger_train
      when 'back'
        break
      end
    end
  end

  def edit_route
    puts 'Choose route to edit:'

    route = select_route

    loop do
      puts route.show_stations.to_s
      puts '1 - to add station'
      puts '2 - to remove station'
      puts "type 'back' to go back"

      command = gets.chomp

      case command
      when '1'
        # избегаем дублирования станций в маршруте
        available_stations = @stations.reject { |station| route.stations.include?(station) }
        route.add(select_station(available_stations)) if available_stations.any?
      when '2'
        # чтобы не весь список станций выводился, а только тот, которые действительно есть в маршруте
        route.remove(select_station(route.stations[1..-2])) if route.stations.length > 2
      when 'back'
        break
      end
    end
  end

  def control_train
    puts 'Choose train to control: '

    train = select_train

    loop do
      puts "Train №#{train.id}, type: #{train.type}, carriages: #{train.carriages.length}"
      if train.route
        puts "  Route: #{train.route.show_stations}"
        puts "    Current station: #{train.current_station.name}"
      end
      puts '1 - assign route'
      puts '2 - add carriage'
      puts '3 - remove carriage'
      puts '4 - go forward'
      puts '5 - go back'
      puts '6 - show carriages'
      puts '7 - fill carriage'
      puts "type 'back' to return to previous menu"

      command = gets.chomp

      case command
      when '1'
        train.route = select_route
      when '2'
        create_carriage(train)
      when '3'
        train.remove_carriage
      when '4'
        train.go_forward
      when '5'
        train.go_back
      when '6'
        carriages_list(train)
      when '7'
        carriage = select_carriage(train)
        case carriage.type
        when :cargo
          print 'Enter cargo size: '
          size = gets.chomp.to_i
          carriage.take_volume(size)
        when :passenger
          carriage.take_seat
        end
        carriages_list(train)
      when 'back'
        break
      else
        puts 'Error: wrong command! Try again!'
      end
    end
  end

  def create_carriage(train)
    case train.type
    when :cargo
      print 'Enter carriage volume: '
      size = gets.chomp.to_i
      train.add_carriage(CargoCarriage.new(size))
    when :passenger
      print 'Enter carriage seats: '
      size = gets.chomp.to_i
      train.add_carriage(PassengerCarriage.new(size))
    end
  end

  def station_list
    @stations.each_with_index do |station, i|
      puts "#{i + 1} - #{station.name} "
      j = 0
      station.each_train do |train|
        puts "  #{j += 1} - №#{train.id}, type: #{train.type}, carriages: #{train.carriages.length}"

        carriages_list(train)
      end
    end
  end

  def carriages_list(train)
    k = 0
    train.each_carriage do |carriage|
      case carriage.type
      when :cargo
        puts "    #{k += 1} - type: #{carriage.type}, free volume: #{carriage.free_volume}, occupied volume: #{carriage.occupied_volume}"
      when :passenger
        puts "    #{k += 1} - type: #{carriage.type}, free seats: #{carriage.free_seats}, occupied seats: #{carriage.occupied_seats}"
      else
        puts "    #{k += 1} - type: undefined"
      end
    end
  end

  def create_station
    puts '  ..creating station'
    print 'Enter new station name: '

    name = gets.chomp

    begin
      @stations << Station.new(name)
      puts "Station #{name} successfully created!"
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end

  def create_route
    puts '  ..creating route'

    if @stations.length < 2
      puts 'Error: There should be at least 2 stations to create route!'

      return
    end

    puts '    choose departure station:'

    departure_station = select_station

    puts "[#{departure_station.name} -- ...]"
    puts '    choose destination station:'

    destination_station = select_station
    @routes << Route.new(departure_station, destination_station)

    puts "[#{departure_station.name} -- #{destination_station.name}]"
  end

  def create_cargo_train
    puts '  ..creating cargo train'
    print 'Enter cargo train identifier: '

    id = gets.chomp

    begin
      @trains << CargoTrain.new(id)
      puts "Cargo train №-#{id} successfully created!"
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end

  def create_passenger_train
    puts '  ..creating passenger train'
    print 'Enter passenger train identifier: '

    id = gets.chomp

    begin
      @trains << PassengerTrain.new(id)
      puts "Passenger train №-#{id} successfully created!"
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end

  def select_station(stations = @stations)
    loop do
      stations.each_with_index { |elem, i| puts "#{i + 1} - #{elem.name} " }
      index = gets.chomp.to_i

      return stations[index - 1] if stations[index - 1]

      puts 'Error: wrong station number'
    end
  end

  def select_route
    loop do
      @routes.each_with_index { |elem, i| puts "#{i + 1} - #{elem.show_stations} " }
      index = gets.chomp.to_i

      return @routes[index - 1] if @routes[index - 1]

      puts 'Error: wrong route number'
    end
  end

  def select_train
    loop do
      @trains.each_with_index { |elem, i| puts "#{i + 1} - #{elem.id} " }
      index = gets.chomp.to_i

      return @trains[index - 1] if @trains[index - 1]

      puts 'Error: wrong train number'
    end
  end

  def select_carriage(train)
    loop do
      carriages_list(train)
      index = gets.chomp.to_i

      return train.carriages[index - 1] if train.carriages[index - 1]

      puts 'Error: wrong carriage number'
    end
  end
end
