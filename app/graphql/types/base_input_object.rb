module Types
  class BaseInputObject < GraphQL::Schema::InputObject
    argument_class Types::BaseArgument
    argument :data_source_id, Types::GlobalId, required: true
  end
end
