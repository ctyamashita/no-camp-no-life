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

  def my_cars?
    true
  end

  def user_is_owner?
    record.car.user == user
  end
end
