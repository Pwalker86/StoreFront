# frozen_string_literal: true

class TabPanelComponent < ViewComponent::Base
  def initialize(turbo_target:, turbo_path:, hidden_on_load:)
    @turbo_target = turbo_target
    @turbo_path = turbo_path
    @hidden_on_load = hidden_on_load
  end

  def call
    tag.div(data: { tabs_target: "panel" }, class: class_names({ hidden: @hidden_on_load })) do
      tag.turbo_frame id: @turbo_target, src: @turbo_path do
        tag.div(class: "grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6 justify-items-center") do
          render SkeletonLoaderComponent.new(count: 6, variant: "card")
        end
      end
    end
  end
end
