module Mutations
  module  CustomPunditIntegration
    def guard_by_policy(policy_class, permission_method)
      policy_class.constantize.new(context[:current_user], nil).send(permission_method)
    end
  end
end