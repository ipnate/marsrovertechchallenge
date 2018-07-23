require './lib/instructions.rb'
require './lib/rover.rb'
require './lib/world.rb'

instructions = Instructions.new('instructions.txt')

@world = World.new(instructions.bound_x,instructions.bound_y)

rover_instruction_sets = instructions.process_instructions
@rovers  = []

rover_instruction_sets.each do |instruction_set|
  rover = Rover.new(instruction_set[:landing])
  rover.store_navication(instruction_set[:navigate])
  @rovers << rover
end

@world.land_rovers(@rovers)
@world.navigate_rovers(@rovers)

puts @world.rover_locations
puts @world.show_grid
