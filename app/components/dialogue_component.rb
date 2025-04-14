# frozen_string_literal: true

class DialogueComponent < ViewComponent::Base
  renders_one :trigger

  attr_reader :title, :width_class, :cookie_name, :auto_open

  def initialize(title: nil, width_class: "max-w-lg", cookie_name: nil, auto_open: false)
    @title = title
    @width_class = width_class
    @cookie_name = cookie_name
    @auto_open = auto_open
  end
end
