class StorePolicy < ApplicationPolicy
  def show?
    true
  end

  def index?; false; end
  def create?; false; end
  def update?; false; end
  def destroy?; false; end
end
