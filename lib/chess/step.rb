require_relative 'coordinates'

module Chess
  class Step
    attr_reader :coordinates, :parent

    def initialize(coordinates, parent = nil)
      @parent = parent
      @coordinates = Coordinates.new(coordinates)
    end
  end
end
