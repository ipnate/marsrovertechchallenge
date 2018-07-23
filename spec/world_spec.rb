require './lib/world.rb'
require './lib/instructions.rb'
require './lib/rover.rb'


describe 'World' do

    before :each do
      @world = World.new(5,5)
    end

	context 'when created' do

		it 'has a size determined by the bounds' do
			expect(@world.grid.count).to be(49)
		end

		it 'each coordinate states whether its empty' do
			expect(@world.grid["1,1"]).to eq('----------')
		end

	end

  context 'integrations' do
    before :each do
      instructions = Instructions.new('./spec/spec_instructions.txt')

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
    end

    describe '#rover_locations' do
      it 'tries to land and navigate' do
        expect(@world.rover_locations).to eq(["1 5 N", "4 1 E"])
      end
    end

    describe '#show_grid' do
      it 'is the correct size' do
        expect(@world.show_grid.count).to eq(6)
      end

      it 'build the grid' do
        expect(@world.show_grid[0]).to eq("---------- --END---N- ---------- ---------- ---------- ----------")
        expect(@world.show_grid[1]).to eq("---------- ---------- ---------- ---------- ---------- ----------")
        expect(@world.show_grid[2]).to eq("---------- ---------- ---------- ---------- ---------- ----------")
        expect(@world.show_grid[3]).to eq("---------- ---------- -START--E- ---------- ---------- ----------")
        expect(@world.show_grid[4]).to eq("---------- -START--N- ---------- ---------- --END---E- ----------")
        expect(@world.show_grid[5]).to eq("---------- ---------- ---------- ---------- ---------- ----------")
      end
    end
  end

  context 'integrations - collision' do
    before :each do
      instructions = Instructions.new('./spec/broken_spec_instructions.txt')

      @world = World.new(instructions.bound_x,instructions.bound_y)

      rover_instruction_sets = instructions.process_instructions
      @rovers  = []

      rover_instruction_sets.each do |instruction_set|
        rover = Rover.new(instruction_set[:landing])
        rover.store_navication(instruction_set[:navigate])
        @rovers << rover
      end

      @world.land_rovers(@rovers)
    end

    describe '#rover_locations' do
      it 'raises a an error on collision' do
        expect{@world.navigate_rovers(@rovers)}.to raise_error(StandardError)
      end
    end
  end

end
