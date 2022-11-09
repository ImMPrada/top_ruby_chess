require_relative 'coordinates'

module Chess
  class Step
    attr_reader :coordinates, :prev_step

    def initialize(coordinates, prev_step = nil)
      @prev_step = prev_step
      @coordinates = Coordinates.new(coordinates)
    end
  end
end
