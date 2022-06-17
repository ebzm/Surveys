module Filtering
  class Interval
    class << self
      def extreme_values_filter(scope:, indicator: , max:, min:)
        return scope if indicator == nil
        scope.select {|v| v if v.send(indicator.to_sym) <= max && v.send(indicator.to_sym) >= min}
      end
    end
  end
end