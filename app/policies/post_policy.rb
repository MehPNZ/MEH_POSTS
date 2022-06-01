# frozen_string_literal: true

class PostPolicy < ApplicationPolicy
  def create?
    !user.guest? && !user.banned_role?
  end

  def update?
    user.admin_role? || user.moderator_role? || user.author?(record) && !user.banned_role?
  end

  def destroy?
    user.admin_role? || user.author?(record) && !user.banned_role?
  end

  def index?
    true
  end

  def show?
    true
  end
end
