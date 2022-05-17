class BookingPolicy < ApplicationPolicy
  def create?
    true
  end

  class Scope < Scope

    def show?
      true
    end

    def update?
      user_is_owner?
    end

    def resolve
      scope.all
    end
  end
end
