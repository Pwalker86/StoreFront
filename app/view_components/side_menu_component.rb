class SideMenuComponent < ViewComponent::Base
  attr_reader :links, :title

  def initialize(links:, title: "Menu")
    @links = links
    @title = title
  end

  # helper method to if it's a :delete, :patch, etc.
  def method(link)
    if link[:method]
      link[:method]
    else
      :get
    end
  end
end
