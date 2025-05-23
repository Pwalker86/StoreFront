# frozen_string_literal: true

class SkeletonLoaderComponent < ViewComponent::Base
  def initialize(count:, variant:)
    @count = count
    # TODO: can use variant for different style of skeletons
    @variant = variant
  end
end
