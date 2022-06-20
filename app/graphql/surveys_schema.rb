class SurveysSchema < GraphQL::Schema
  mutation(Types::MutationType)
  query(Types::QueryType)

  # For batch-loading (see https://graphql-ruby.org/dataloader/overview.html)
  use GraphQL::Dataloader

  class << self

    def type_error(err, context)
      # if err.is_a?(GraphQL::InvalidNullError)
      #   # report to your bug tracker here
      #   return nil
      # end
      super
    end
  
    # Union and Interface Resolution
    def resolve_type(abstract_type, obj, ctx)
      "Types::#{obj.class.base_class.name}".constantize
    end

    # Relay-style Object Identification:

    # Return a string global id for `object`
    def id_from_object(object, _type_definition, query_ctx)
      generate_global_id(object.class.name.to_s, object.id)
    end

    # Given a string global id, find the object
    def object_from_id(id, query_ctx)
      # If field field type is a `Types::GlobalID`, then it gets parsed before arriving here.
      # Only `ID` fields need to be parsed from a string into a URN.
      urn = if id.is_a?(::Urn::Generic)
        id
      else
        parse_global_id(id)
      end

      urn.entity_class.find_by(id: urn.entity_id)
    end

    def generate_global_id(entity_type, entity_id)
      scope = IdHasher.make_scope(entity_type)
      hashed_id = IdHasher.new.encode(type: scope, id: entity_id)

      ::Urn::Survey.new_hashed_id(scope, hashed_id).to_urn
    end

    # Given a global ID (URN), decode the ID and create a new URN with the clear ID.
    def parse_global_id(id)
      urn = ::Urn.parse(id)

      # For now, always reject un-hashed IDs. This may become an environment or schema setting.
      # May be desirable to return this as an error or just `nil`?
      raise GraphQL::ExecutionError, "Entity ID not accepted." unless urn.hashed_id?

      clear_ids = IdHasher.new.decode(scope: urn.entity_type, hashed_id: urn.hashed_id)
      raise GraphQL::ExecutionError, "Invalid hash" if clear_ids.none?

      clear_id = clear_ids.fetch(0)

      Urn::Survey.new_clear_id(urn.entity_type, clear_id)
    rescue Urn::ParseError => ex
      raise GraphQL::ExecutionError, ex.message
    end

    private

    def id_hasher()
      IdHasher.new
    end
  end
end
