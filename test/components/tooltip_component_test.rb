# frozen_string_literal: true

require "test_helper"

class TooltipComponentTest < ViewComponent::TestCase
  test "renders component with tooltip text and content" do
    component = render_inline(
      TooltipComponent.new( tooltip_text: "This is a tooltip").with_content("<div>Content</div>")
    )

    # Check that the controller attribute is set
    assert_selector("div[data-controller='tooltip']")

    # Check that the tooltip text is correctly set as a data attribute
    assert_selector("div[data-tooltip-text-value='This is a tooltip']")

    # Check that the tooltip trigger exists
    assert_selector("[data-tooltip-target='trigger']")

    # Check that the anchor exists
    assert_selector("[data-tooltip-target='anchor']")

    # Check that content is rendered inside the anchor
    # assert_selector("[data-tooltip-target='anchor']", text: "This is a tooltip")
  end
end
