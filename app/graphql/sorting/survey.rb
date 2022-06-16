# frozen_string_literal: true

module Sorting
  module Survey
    class Input < Types::BaseSortObject
      argument :label, Types::SortDirection, required: false
      argument :created_at, Types::SortDirection, required: false
    end

    include Sorting::Base

    extend self
  end
end