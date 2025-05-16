  class Admin::ServicePolicy < ApplicationPolicy
    def index?
     true
    end

    def show?
      belongs_to_store_admin?
    end

    def new?
      belongs_to_store_admin?
    end

    def create?
      # record == Store
      record.store_admin == user
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
      record.store.store_admin == user
    end
  end
