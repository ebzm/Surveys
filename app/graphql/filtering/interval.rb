# frozen_string_literal: true

module Filtering
  class Interval
    class << self
      def filter_by_interval(scope:, indicator:, max:, min:)
        return scope if indicator.nil?

        scope.where(indicator => [min..max])
      end
    end
  end
end
