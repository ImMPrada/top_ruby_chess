require_relative 'chess'

module Chess
  class Board
    attr_reader :cells, :pieces
  
    Cell = Struct.new(:name, :occuped, :team, :row, :column)
    Pieces = Struct.new(:team, :king, :queens, :bishops, :knights, :rooks, :pawns)
    
    def initialize
      @cells = {}

      generate_cells
    end

    private

    def generate_cells
      COLUMNS.each do |column|
        @cells[column.to_sym] = {}
        (MIN_INDEX..MAX_INDEX).each do |row_index|
          row = row_index + 1
          @cells[column.to_sym][row] = Cell.new("#{column}#{row}", false, nil, row, column)
        end
      end
    end
  end
end
