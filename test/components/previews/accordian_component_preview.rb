# frozen_string_literal: true

class AccordianComponentPreview < ViewComponent::Preview
  def default
    render(AccordianComponent.new(summaryText: "summaryText", detailText: Faker::Lorem.paragraphs(number: 9).join(" ")))
  end

  def with_block
    render(AccordianComponent.new(summaryText: "summaryText", detailText: Faker::Lorem.paragraphs(number: 9).join(" "))) do
      "This preview isn't allowing another component to be rendered as a content block, but you can do that, allowing for buttons or links to be included in your accordian."
    end
  end
end
