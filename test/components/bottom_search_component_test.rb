# frozen_string_literal: true

require "test_helper"

class BottomSearchComponentTest < ViewComponent::TestCase
  def test_renders_with_url
    render_inline(BottomSearchComponent.new(url: "/search")).to_html
    assert_component_rendered
    assert_selector "div[data-controller='bottom-search-component']"
    assert_selector "div[data-bottom-search-component-url-value='/search']"
  end

  def test_raise_no_url_error
    assert_raises ArgumentError do
      render_inline(BottomSearchComponent.new(url: nil)).to_html
    end
  end

  def test_renders_with_custom_placeholder
    placeholder = "What do you want?"
    render_inline(BottomSearchComponent.new(url: "/search", input_placeholder: placeholder)).to_html
    assert_component_rendered
    assert_selector "input[placeholder='#{placeholder}']"
  end

  def test_renders_with_custom_trigger_content
    render_inline(BottomSearchComponent.new(url: "/search")) { %(<span>Custom Trigger</span>) }
    assert_component_rendered
    assert_text "Custom Trigger"
  end
end
