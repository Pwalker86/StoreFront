# frozen_string_literal: true

class TabComponent < ViewComponent::Base
  def initialize(has_content:)
    @has_content = has_content
  end

  def call
    tag.button(data: { tabs_target: "tab", action: "tabs#change" }, class: "cursor-pointer border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap py-4 px-1 border-b-2 font-medium text-lg ", aria: { 'selected': false }) do
      content
    end
  end

  def render?
    !!@has_content
  end
end
