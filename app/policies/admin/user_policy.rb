# frozen_string_literal: true

module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      user.admin?
    end

    def create?
      index?
    end

    def update?
      index?
    end

    def destroy?
      index?
    end

    def show?
      index?
    end
  end
end
