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
      rover_instruction_sets.each do |instruction_set|
        rover = Rover.new(instruction_set[:landing])
        rover.store_navication(instruction_set[:navigate])
        @world.land_and_navigate(rover)
      end
    end

    describe '#rover_locations' do
      it 'tries to land and navigate' do
        expect(@world.rover_locations).to eq(['1 3 N','5 1 E', '6 4 S'])
      end
    end

    describe '#show_grid' do
      it 'is the correct size' do
        expect(@world.show_grid.count).to eq(6)
      end

      it 'is the stuff' do
        expect(@world.show_grid[0]).to eq("---------- ---------- ---------- ---------- ---------- -START--N-")
        expect(@world.show_grid[1]).to eq("---------- ---------- ---------- ---------- ---------- ----------")
        expect(@world.show_grid[2]).to eq("---------- --END---N- ---------- -START--E- ---------- ----------")
        expect(@world.show_grid[3]).to eq("---------- -START--N- ---------- ---------- ---------- ----------")
        expect(@world.show_grid[4]).to eq("---------- ---------- ---------- ---------- ---------- --END---E-")
        expect(@world.show_grid[5]).to eq("---------- ---------- ---------- ---------- ---------- ----------")
      end
    end
  end

end
