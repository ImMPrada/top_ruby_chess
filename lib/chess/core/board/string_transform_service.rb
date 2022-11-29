module Chess
  module StringTransformService
    def to_s
      response = "     a  b  c  d  e  f  g  h \n"

      (MIN_INDEX..MAX_INDEX).each do |row_index|
        row_index = MAX_INDEX - row_index
        response += "  #{row_index + 1} "
        COLUMNS.each do |column|
          response += @cells[column.to_sym][row_index].to_s
        end

        response += " #{row_index + 1}\n"
      end

      "#{response}     a  b  c  d  e  f  g  h \n"
    end
  end
end
