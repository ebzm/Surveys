# frozen_string_literal: true

module Mutations
  class DestroyRecord < Mutations::BaseMutation
    argument :record_id, ID, required: true

    field :errors, [String], null: true

    def resolve(record_id:)
      record = SurveysSchema.object_from_id(record_id, nil)
      record.destroy
    end
  end
end
