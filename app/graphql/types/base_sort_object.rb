# frozen_string_literal: true

module Types
  class BaseSortObject < BaseInputObject
    def self.default_graphql_name
      # e.g. "Sorting::User::Input" => "UserSortInput"
      name.sub(/^Sorting::/, '').sub(/\bInput\b/, 'SortInput').gsub('::', '')
    end

    # Define a mapping of sort input object attributes to SQL column names
    # e.g. { registered_at: :created_at }
    def self.sort_attribute_column_map
      {}
    end
  end
end
