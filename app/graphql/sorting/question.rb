# frozen_string_literal: true

module Sorting
  module Question
    class Input < Types::BaseSortObject
      argument :questiontype, Types::SortDirection, required: false
    end

    include Sorting::Base

    extend self
  end
end