  class Admin::StoreImagePolicy < ApplicationPolicy
    def show?
      belongs_to_store_admin?
    end

    def new?
      belongs_to_store_admin?
    end

    def create?
      belongs_to_store_admin?
    end

    def edit?
      belongs_to_store_admin?
    end

    def update?
      belongs_to_store_admin?
    end

    def destroy?
      belongs_to_store_admin?
    end

    private

    def belongs_to_store_admin?
      record.store_admin == user
    end
  end
