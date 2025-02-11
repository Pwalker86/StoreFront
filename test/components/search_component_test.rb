# frozen_string_literal: true

require "test_helper"

class SearchComponentTest < ViewComponent::TestCase
  def test_renders_with_url
    render_inline(SearchComponent.new(url: "/home_search")).to_html
    assert_component_rendered
    assert_selector "form[action='/home_search']"
  end
end
