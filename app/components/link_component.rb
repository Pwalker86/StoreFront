# frozen_string_literal: true

class LinkComponent < ViewComponent::Base
  def initialize(text:, path:, dataset: {})
    @text = text
    @path = path
    @dataset = dataset
  end

  def call
    tag.a(@text, href: @path, data: @dataset, class: "button")
  end
end
