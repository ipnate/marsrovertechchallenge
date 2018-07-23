require 'byebug'
class World
  attr_reader :grid, :rover_locations

  def initialize(x_coordinate, y_coordinate)
    @grid = {}
    @rovers = []
    @x_original = x_coordinate
    @y_original = y_coordinate
    build_grid(x_coordinate, y_coordinate)
    @rover_locations = []
  end

  def land_rovers(rovers)
    rovers.each do |rover|
      update_location(rover.x_coordinate, rover.y_coordinate, rover.orientation, '-START-')
    end
  end

  def navigate_rovers(rovers)
    rovers.each do |rover|
      execute_instructions_for(rover)
      @rover_locations << "#{@x_coordinate} #{@y_coordinate} #{@orientation}"
      update_location(@x_coordinate, @y_coordinate, @orientation, '--END--')
    end
  end

  def show_grid
    Array.new(@y_original+1).map.with_index do |a, y|
      Array.new(@x_original+1).map.with_index do |_, x|
        @grid["#{x},#{y}"]
      end.join(" ")
    end.reverse
  end

  private

  def build_grid(x_coordinate, y_coordinate)
    (0..x_coordinate+1).map do |x|
      (0..y_coordinate+1).map do |y|
         @grid["#{x},#{y}"] = '----------'
      end
    end
  end

  def execute_instructions_for(rover)
    @orientation = rover.orientation
    @y_coordinate = rover.y_coordinate.to_i
    @x_coordinate = rover.x_coordinate.to_i
    rover.instructions.each do |instruction|
      case instruction
      when 'L'
        @orientation = turn_left
      when 'R'
        @orientation = turn_right
      when 'M'
        break unless move(rover)
      end
    end
  end

  def turn_left
    new_orientation = {'N' => "W", 'S' => "E", 'E' => "N", 'W' => "S"}
    new_orientation[@orientation]
  end

  def turn_right
    new_orientation = {'N' => "E", 'S' => "W", 'E' => "S", 'W' => "N"}
    new_orientation[@orientation]
  end

  def move(rover)
    ["N", "S"].include?(@orientation) ? move_y_coordinate : move_x_coordinate
  end

  def move_y_coordinate
    y_coordinate = @orientation == "N" ? @y_coordinate + 1 : @y_coordinate - 1
    grid_location = @grid["#{@x_coordinate},#{y_coordinate}"]

    lost(grid_location)

    @y_coordinate = y_coordinate
  end

  def move_x_coordinate
    x_coordinate = @orientation == "E" ? @x_coordinate + 1 : @x_coordinate - 1
    grid_location = @grid["#{x_coordinate},#{@y_coordinate}"]

    lost(grid_location)

    @x_coordinate = x_coordinate
  end

  def lost(grid_location)
    raise StandardError.new("Collision detected") if grid_location != '----------'
  end

  def update_location(x, y, orientation,placeholder)
    @grid["#{x},#{y}"] = "#{placeholder}-#{orientation}-"
  end
end
