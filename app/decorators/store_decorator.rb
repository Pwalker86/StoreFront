class StoreDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def mission_statement
    if object.mission_statement.present?
     object.mission_statement.truncate(50, separator: " ", omission: "... (Read more)")
    else
      ""
    end
  end
end
