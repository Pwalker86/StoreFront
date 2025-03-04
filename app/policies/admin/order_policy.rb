class Admin::OrderPolicy < ApplicationPolicy
  def show?
    belongs_to_user?
  end

  def index?
    belongs_to_user?
  end

  def create?; false; end
  def update?; false; end
  def destroy?; false; end

  private

  def belongs_to_user?
    record.orderable == user
  end
end
