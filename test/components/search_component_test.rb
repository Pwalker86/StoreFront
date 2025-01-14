# frozen_string_literal: true

require "test_helper"

class SearchComponentTest < ViewComponent::TestCase
  def test_renders_with_url
    assert_equal(
      %(<input></input>),
    render_inline(SearchComponent.new(url: "/home_search")).to_html
    )
  end
end
