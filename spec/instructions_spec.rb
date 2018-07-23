require './lib/instructions.rb'

describe Instructions do
  before :each do
    @instructions = Instructions.new('./spec/spec_instructions.txt')
  end

  describe '.new' do
    it 'sets the x_bound and y_bound' do
      expect(@instructions.bound_x).to eq(5)
      expect(@instructions.bound_y).to eq(5)
    end
  end

  describe '#process_instructions' do
    it 'returns an list of instructions for each rover' do
      instructions = [
        {:landing=>["1", "1", "N"], :navigate=>["M", "M", "M", "M"]},
        {:landing=>["2", "2", "E"], :navigate=>["M", "R", "M", "L", "M"]}
      ]
      expect(@instructions.process_instructions).to eq(instructions)
    end
  end
end
