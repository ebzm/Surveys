# frozen_string_literal: true

module Sources
  module LoaderMethods
    # Defer loading a child record where the foreign key is on the current object
    # Use this for `belongs_to` relations
    #
    # Example when you're on a `User` and want to load their account:
    #   defer_batch_load(::Account, object.account_id
    #
    def defer_batch_load(scope, id)
      return nil if id.nil?

      dataloader.with(Sources::ActiveRecordObject, scope).load(id)
    end

    # Defer loading a single record that has a foreign key reference to the parent (`ref`) record.
    # Use this for `has_one` relations.
    #
    # For example, `Address` has a polymorphic `addressable`, so if you want to load an
    # address from the owner/parent record such as `Account` you would do:
    #   defer_load_has_one(::Address, :addressable, object)
    #
    def defer_load_has_one(scope, foreign_key, ref, options = {})
      defer_load_has_many(scope, foreign_key, ref, options)&.first
    end

    # Defer loading a records that have a foreign key reference to the parent (`ref`) record.
    # Use this for `has_many` relations.
    #
    # The `foreign_key` field defines the name of the foreign key or polymorphic relation on the foreign record.
    #
    def defer_load_has_many(scope, foreign_key, ref, options = {})
      return nil if ref.nil?

      dataloader.with(Sources::ActiveRecordForeignObjects, scope, foreign_key, options).load(ref)
    end
  end
end
