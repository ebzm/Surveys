module Admin
  module UsersHelper
    def users_account_types
      User.account_types.keys.map do |type|
        [ type.titleize, type ]
      end
    end
  end
end