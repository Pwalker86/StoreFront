# frozen_string_literal: true

require "test_helper"

class SearchComponentTest < ViewComponent::TestCase
  def test_renders_with_url
    render_inline(SearchComponent.new(url: "/home_search")).to_html
    assert_component_rendered
    assert_selector "form[action='/home_search']"
  end

  def test_raise_no_url_error
    assert_raises ArgumentError do
      render_inline(SearchComponent.new(url: nil)).to_html
    end
  end

  def test_renders_with_custom_placeholder
    placeholder = "What do you want?"
    render_inline(SearchComponent.new(url: "/home_search", input_placeholder: placeholder)).to_html
    assert_component_rendered
    assert_selector "input[placeholder='#{placeholder}']"
  end
end
