class CartPolicy < ApplicationPolicy
  def show?
    belongs_to_user?
  end

  def index?; false; end
  def create?; false; end
  def update?
    belongs_to_user?
  end
  def destroy?; false; end

  private

  def belongs_to_user?
    record.guest == user || record.user == user
  end
end
