# frozen_string_literal: true

class TabControlComponent < ViewComponent::Base
  renders_many :tabs, TabComponent
  renders_many :tab_panels, TabPanelComponent

  def intialize(**args)
    super
  end
end
