# frozen_string_literal: true

module Mutations
  class DestroyRecord < Mutations::BaseMutation
    argument :record_id, ID, required: true

    field :errors, [String], null: true

    def resolve(record_id:)
      record = SurveysSchema.object_from_id(record_id, nil)

      clazz = record.class.to_s + 'Policy'
      return unless clazz == 'UserPolicy' or guard_by_policy('update?', policy_class: clazz )

      record.destroy
    end
  end
end
