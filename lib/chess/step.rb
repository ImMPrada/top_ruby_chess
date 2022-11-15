require_relative 'position'

module Chess
  class Step
    attr_reader :position, :prev_step

    def initialize(position_algebraic, prev_step = nil)
      @prev_step = prev_step
      @position = Position.new(position_algebraic)
    end
  end
end
