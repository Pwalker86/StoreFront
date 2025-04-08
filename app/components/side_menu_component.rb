class SideMenuComponent < ViewComponent::Base
  attr_reader :links, :title

  def initialize(links:, title: "Menu")
    @links = links
    @title = title
  end
end
