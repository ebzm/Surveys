module Admin
  class UserPolicy < ApplicationPolicy
    def create?
      user.admin?
    end
  
    def update?
      user.admin?
    end
  
    def destroy?
      user.admin?
    end
  
    def index?
      user.admin?
    end
  
    def show?
      user.admin?
    end
  end
end