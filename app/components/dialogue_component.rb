# frozen_string_literal: true

class DialogueComponent < ViewComponent::Base
  renders_one :trigger

  attr_reader :title, :width_class

  def initialize(title: nil, width_class: "max-w-lg")
    @title = title
    @width_class = width_class
  end
end
