# frozen_string_literal: true

module Sorting
  module Base
    CUSTOM_SORTING = {}
    CUSTOM_COLUMN = {}
    FINAL_SORTING = { id: :asc }

    def sort_with(scope, inputs)
      return scope.order(self::FINAL_SORTING) if inputs.empty?

      scope = scope.unscope(:order)

      inputs.map(&:to_h).each do |input|
        input.each do |key, direction|
          if (custom_column_key = self::CUSTOM_COLUMN[key])
            scope = scope.order(custom_column_key => direction)
            next
          end

          if (custom_sort_proc = self::CUSTOM_SORTING[key])
            scope = custom_sort_proc.call(scope, direction)
            next
          end

          scope = scope.order(key => direction)
        end
      end

      scope.order(self::FINAL_SORTING)
    end
  end
end
