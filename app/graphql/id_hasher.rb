# frozen_string_literal: true

class IdHasher
  MINIMUM_ID_HASH_LENGTH = 8

  @hashing_salt = nil

  class << self
    def make_scope(scope)
      # e.g. CustomFields::TextField => custom_fields/text_field
      scope.gsub("::", "/").underscore
    end
  end

  def initialize(user_or_hashing_salt)
    @hashing_salt = if user_or_hashing_salt.is_a?(::User)
      user_or_hashing_salt.account.hashing_salt
    else
      user_or_hashing_salt
    end
  end

  def encode(type:, id:)
    scope = self.class.make_scope(type)
    hashids(scope: scope).encode(id)
  end

  def decode(scope:, hashed_id:)
    hashids(scope: scope).decode(hashed_id)
  end

  # Create a `Hashids` instance with the user's hashing salt and the "scope" of
  # the object we're generating and ID for.
  def hashids(scope:)
    # Including the type in the salt means a numeric ID won't be the same
    # for different types. e.g. User #1 and Account #1 have different IDs
    hashing_salt = "#{scope}.#{hashing_salt}"

    Hashids.new(hashing_salt, MINIMUM_ID_HASH_LENGTH)
  end
end
