# app/forms/uniform_form_builder.rb
# WIP
# TODO:
#  - fix select helper to properly accept all the normal options.
#  - general resliency for all helpers to accept options
class UniformFormBuilder < ActionView::Helpers::FormBuilder
  include ActionView::Helpers::OutputSafetyHelper
  # map AR types → form helper
  FIELD_MAPPINGS = {
    string:   :text_field,
    text:     :text_area,
    integer:  :number_field,
    float:    :number_field,
    decimal:  :number_field,
    date:     :date_field,
    datetime: :datetime_local_field,
    time:     :time_field,
    boolean:  :check_box
  }.freeze

  # FormHelper will pass you `object` as an Array when you do:
  #   form_with model: [current_admin, store, service], builder: UniformFormBuilder
  #
  # You only care about the last element as “the actual model”,
  # so pull it out here before calling `super`.
  def initialize(object_name, object, template, options, proc = nil)
    if object.is_a?(Array)
      # save the parents in case you need them later
      @polymorphic_parents = object[0..-2]
      # unwrap to the real AR instance
      object = object.last
    end

    super(object_name, object, template, options)
  end

  # Public entry point: for a given list of fields (symbols) and overrides,
  # outputs HTML for all the label+input pairs.
  #
  # - fields:   Array<Symbol> — which columns (or virtual attrs) to render
  # - overrides: {
  #     foo: { as: :text_area, options: { rows: 5, class: 'foo-input' } },
  #     bar: { options: { placeholder: '…' } }
  #   }
  def uniform_fields(fields: object.class.column_names.map(&:to_sym), overrides: {})
    safe_join(
      fields.map { |attr|
        opts       = overrides[attr].to_h
        as_helper  = opts.delete(:as)        || default_helper_for(attr)
        html_opts  = opts.delete(:options)   || {}
        wrap_field(attr, as_helper, html_opts)
      }
    )
  end

  private

  # wrap each label+input in a .form-group div (you can adjust classes here)
  def wrap_field(attr, helper_name, html_opts)
    @template.content_tag :div, class: "form-group" do
      label(attr, class: "form-label") +
      send(helper_name, attr, default_input_options.merge(html_opts))
    end
  end

  # default CSS classes for every input
  def default_input_options
    { class: "mt-1 block w-full rounded-md border-2 border-gray-400 shadow-sm focus:border-indigo-500 focus:ring focus:ring-indigo-500 focus:ring-opacity-50 px-2 py-1" }
  end

  # figure out which helper to use by inspecting the model’s column type
  def default_helper_for(attr)
    if enum_select?(attr)
      :select
    else
      column = object.class.columns_hash[attr.to_s]
      raise ArgumentError, "Unknown attribute `#{attr}` on #{object.class}" unless column

      FIELD_MAPPINGS[column.type] || :text_field
    end
  end

  # if this column is an ActiveRecord::Enum, render a <select> of its keys
  def enum_select?(attr)
    object.class.defined_enums.key?(attr.to_s)
  end

  # override `select` behaviour to auto‑pull enum choices
  def select(method, choices = nil, options = {}, html_options = {}, &block)
    if enum_select?(method) && choices.nil?
      enum_values = object.class.send(method.to_s.pluralize).keys
      super(method, enum_values.map { |v| [ v.humanize, v ] }, options, html_options, &block)
    else
      super
    end
  end
end
