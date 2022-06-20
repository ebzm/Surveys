# frozen_string_literal: true

module Sorting
  module QuestionGroup
    class Input < Types::BaseSortObject
      argument :label, Types::SortDirection, required: false
    end

    include Sorting::Base

    extend self
  end
end
