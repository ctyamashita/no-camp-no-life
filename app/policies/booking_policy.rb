class BookingPolicy < ApplicationPolicy
  class Scope < Scope
    def create?
      true
    end

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
