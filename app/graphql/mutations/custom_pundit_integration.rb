module Mutations
  module  CustomPunditIntegration
    def guard_by_policy(permission_method, policy_class: policy)
      policy_class.constantize.new(context[:current_user], nil).send(permission_method)
    end

    def policy
      self.class.to_s.split(/(?=[A-Z])/).drop(2).join  + 'Policy'
    end
  end
end