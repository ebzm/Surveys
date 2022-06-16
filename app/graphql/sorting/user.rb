# frozen_string_literal: true

module Sorting
  module User
    class Input < Types::BaseSortObject
      argument :first_name, Types::SortDirection, required: false
      argument :last_name, Types::SortDirection, required: false
      argument :email, Types::SortDirection, required: false
    end

    include Sorting::Base

    extend self
  end
end
