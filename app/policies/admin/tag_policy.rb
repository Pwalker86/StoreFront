class Admin::TagPolicy < ApplicationPolicy
  def new?
    belongs_to_store_admin?
  end

  def create?
    belongs_to_store_admin?
  end

  def destroy?
    belongs_to_store_admin?
  end

  private

  def belongs_to_store_admin?
    # record is @product
    record.store.store_admin == user
  end
end
