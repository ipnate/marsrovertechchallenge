require 'byebug'
class Rover
  attr_accessor :x_coordinate, :y_coordinate, :orientation
  attr_reader :instructions

  def initialize(landing_instructions)
    @x_coordinate, @y_coordinate, @orientation = landing_instructions
  end

  def store_navication(instructions)
    @instructions = instructions
  end
end
