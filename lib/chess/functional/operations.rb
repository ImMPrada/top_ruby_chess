module Chess
  module Operation
    def sum_arrays(array1, array2)
      return unless array1.size == array2.size

      result = []
      array1.size.times { |i| result << array1[i] + array2[i] }

      result
    end
  end
end
