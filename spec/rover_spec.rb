require './lib/rover.rb'

describe Rover do
  context 'populates all the fields' do
    it 'sets x_coordinate, y_coordinate, orientation and instructions' do
      rover = Rover.new(['1','1','N'])
      expect(rover.x_coordinate).to eq('1')
      expect(rover.y_coordinate).to eq('1')
      expect(rover.orientation).to eq('N')
      rover.store_navication(["L", "M", "L", "M", "L", "M", "L", "M", "M"])
      expect(rover.instructions).to eq(["L", "M", "L", "M", "L", "M", "L", "M", "M"])
    end
  end
end
