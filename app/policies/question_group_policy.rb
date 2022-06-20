# frozen_string_literal: true

class QuestionGroupPolicy < ApplicationPolicy
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
    true
  end

  def show?
    true
  end
end
