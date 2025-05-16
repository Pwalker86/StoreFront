# frozen_string_literal: true

class TabControlComponent < ViewComponent::Base
  renders_many :tab_panels, TabPanelComponent

  def initialize(tab_names:)
    @tab_names = tab_names
  end
end
