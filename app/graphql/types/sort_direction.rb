# frozen_string_literal: true

module Types
  class SortDirection < Types::BaseEnum
    description 'Used in sorting input object to control the output sort direction'

    value 'ASC', description: 'e.g. A-Z, 0-9'
    value 'DESC', description: 'e.g. Z-A, 9-0'
  end
end
