class Instructions

  def initialize(file)
    @instructions = File.read(file).chars.reject!{|char| char == " " || char == "\n"}
    @bound_x, @bound_y = outer_bounds
    @rover_instruction_sets = []
  end

  def process_instructions
    until @instructions.empty?
      @rover_instruction_sets << {landing: landing_instructions, navigate: navigation_instructions}
    end
    @rover_instruction_sets
  end

  def bound_x
    @bound_x.to_i
  end

  def bound_y
    @bound_y.to_i
  end

  private

  def outer_bounds
    @instructions.shift(2)
  end

  def landing_instructions
    @instructions.shift(3)
  end

  def navigation_instructions
    @instructions.shift(@instructions.take_while{|c| c =~ /[A-Z]/ }.count)
  end
end
