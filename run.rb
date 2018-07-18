require './lib/instructions.rb'
require './lib/rover.rb'
require './lib/world.rb'

instructions = Instructions.new('instructions.txt')

@world = World.new(6,6)

rover_instruction_sets = instructions.process_instructions
rover_instruction_sets.each do |instruction_set|
  rover = Rover.new(instruction_set[:landing])
  rover.store_navication(instruction_set[:navigate])
  @world.land_and_navigate(rover)
end

puts @world.rover_locations
puts @world.show_grid
