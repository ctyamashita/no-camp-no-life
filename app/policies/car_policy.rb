class CarPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      where(user: user)
    end

    def create?
      true
    end

    def show?
      true
    end

    def update?
      user_is_owner?
    end

    def user_is_owner?
      record.user == user
    end
  end
end
