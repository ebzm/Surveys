class AnswerPolicy < ApplicationPolicy
  def create?
    user.employee? || user.admin?
  end

  def update?
    user.employee? || user.admin?
  end

  def destroy?
    user.employee? || user.admin?
  end

  def index?
    true
  end

  def show?
    true
  end
end