module Chess
  module Functional
    module Operations
      def sum_arrays(array1, array2)
        return unless array1.size == array2.size

        result = []
        array1.size.times { |i| result << array1[i] + array2[i] }

        result
      end

      def directive_of(array1, array2)
        return unless array1.size == array2.size && array1.size == 2

        result = [
          array2[0] - array1[0],
          array2[1] - array1[1]
        ]

        result.map do |local_result|
          next if local_result.zero?

          local_result.positive? ? 1 : -1
        end
      end
    end
  end
end
