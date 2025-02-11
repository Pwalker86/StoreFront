class ProductDecorator < Draper::Decorator
  delegate_all

  # def description
  #   object.description.truncate(50, separator: " ", omission: "... (continued)")
  # end
end
