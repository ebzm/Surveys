# frozen_string_literal: true

module Filtering
  class Field
    class << self
      # When `fields` contains only `nil` values, gets default scope.
      # Otherwise, filtering `scope` by present fields,
      # all `fields value` should be a URN::Survey with an `entity_id`
      # `fields` attribute is a hash and it should contain data in format { field1: value1, field2: value2 }
      def filter_by_fields(scope:, fields:)
        present_fields = fields.compact

        return scope if present_fields.empty?

        present_fields.each do |field, value|
          scope = if (assoc = scope.base_class.reflect_on_association(field)) && assoc.polymorphic?
                    # Support for polymorphic association fields, use the GlobalID value type for this.
                    scope.where(assoc.foreign_key => value.entity_id, assoc.foreign_type => value.entity_type)
                  elsif value.is_a?(Array) && value.all? { |v| v.is_a?(Urn::Survey) }
                    # When value is an Array of URN::Survey, AR can create *IN* sql query.
                    scope.where(field.to_s => value.map(&:entity_id))
                  else
                    scope.where(field.to_s => value.is_a?(Urn::Survey) ? value.entity_id : value)
                  end
        end

        scope
      end

      # When `joins_field`, `field` or `value` don't present, gets default scope
      # Otherwise, filtering `scope` with join and present field value
      def filter_by_field_with_joins(scope:, joins_field:, field:, value:)
        if joins_field.blank? || field.blank? || value.blank?
          scope
        else
          scope.joins(joins_field.to_sym).where(joins_field.to_s.pluralize => {
                                                  field.to_sym => value.is_a?(Urn::Survey) ? value.entity_id : value
                                                }).distinct
        end
      end
    end
  end
end
