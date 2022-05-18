class BookingPolicy < ApplicationPolicy
  def create?
    true
  end

  def show?
    true
  end

  def update?
    user_is_owner?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def user_is_owner?
    record.user == user
  end
end
