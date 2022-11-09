module Chess
  class Step
    attr_reader :coordinates, :parent

    def initialize(coordinates, parent = nil)
      @parent = parent
      @coordinates = coordinates
    end
  end
end
