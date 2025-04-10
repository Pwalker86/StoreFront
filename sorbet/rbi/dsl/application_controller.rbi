# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for dynamic methods in `ApplicationController`.
# Please instead update this file by running `bin/tapioca dsl ApplicationController`.


class ApplicationController
  include GeneratedUrlHelpersModule
  include GeneratedPathHelpersModule

  sig { returns(HelperProxy) }
  def helpers; end

  module HelperMethods
    include ::Turbo::DriveHelper
    include ::Turbo::FramesHelper
    include ::Turbo::IncludesHelper
    include ::Turbo::StreamsHelper
    include ::ActionView::Helpers::CaptureHelper
    include ::ActionView::Helpers::OutputSafetyHelper
    include ::ActionView::Helpers::TagHelper
    include ::Turbo::Streams::ActionHelper
    include ::ActionText::ContentHelper
    include ::ActionText::TagHelper
    include ::Importmap::ImportmapTagsHelper
    include ::ActionController::Base::HelperMethods
    include ::Pagy::UrlHelpers
    include ::Pagy::Frontend
    include ::ApplicationHelper
    include ::AdminNavigationHelper
    include ::CartItemsHelper
    include ::CartsHelper
    include ::OrderExportsHelper
    include ::OrderItemsHelper
    include ::OrdersHelper
    include ::PagesHelper
    include ::ProductsHelper
    include ::ReviewsHelper
    include ::ShippingDetailsHelper
    include ::StoreAdmin::FulfillmentPartnersHelper
    include ::StoreAdmin::ProductsHelper
    include ::StoreAdmin::StoresHelper
    include ::StoreImagesHelper
    include ::StoreReviewsHelper
    include ::StoresHelper
    include ::TagsHelper
    include ::UserNavigationHelper
    include ::PreviewHelper
    include ::DeviseHelper
    include ::Pundit::Helper

    sig { returns(T.untyped) }
    def active_user; end

    sig { params(record: T.untyped).returns(T.untyped) }
    def policy(record); end

    sig { params(scope: T.untyped).returns(T.untyped) }
    def pundit_policy_scope(scope); end

    sig { returns(T.untyped) }
    def pundit_user; end
  end

  class HelperProxy < ::ActionView::Base
    include HelperMethods
  end
end
