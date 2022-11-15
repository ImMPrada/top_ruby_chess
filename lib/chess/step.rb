require_relative 'position'

module Chess
  class Step
    attr_reader :position, :prev_step

    def initialize(position_algebraic)
      @prev_step = nil
      @position = Position.new(position_algebraic)
    end

    def add_previous_step(prev_step)
      @prev_step = prev_step
    end
  end
end
