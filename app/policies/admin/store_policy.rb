  class Admin::StorePolicy < ApplicationPolicy
    def index?
      true
    end

    def show?
      belongs_to_store_admin?
    end

    def new?
      user.is_a?(StoreAdmin) && user.store.nil?
    end

    def create?
      user.is_a?(StoreAdmin) && user.store.nil?
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
