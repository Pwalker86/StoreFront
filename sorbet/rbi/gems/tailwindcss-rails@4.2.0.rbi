# typed: true

# DO NOT EDIT MANUALLY
# This is an autogenerated file for types exported from the `tailwindcss-rails` gem.
# Please instead update this file by running `bin/tapioca gem tailwindcss-rails`.


# source://tailwindcss-rails//lib/tailwindcss-rails.rb#1
module Tailwindcss; end

# source://tailwindcss-rails//lib/tailwindcss/commands.rb#4
module Tailwindcss::Commands
  class << self
    # source://tailwindcss-rails//lib/tailwindcss/commands.rb#6
    def compile_command(debug: T.unsafe(nil), **kwargs); end

    # @return [Boolean]
    #
    # source://tailwindcss-rails//lib/tailwindcss/commands.rb#32
    def rails_css_compressor?; end

    # source://tailwindcss-rails//lib/tailwindcss/commands.rb#24
    def watch_command(always: T.unsafe(nil), poll: T.unsafe(nil), **kwargs); end
  end
end

# source://tailwindcss-rails//lib/tailwindcss/engine.rb#4
class Tailwindcss::Engine < ::Rails::Engine
  class << self
    private

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#15
    def __class_attr___callbacks; end

    # source://activesupport/8.0.1/lib/active_support/class_attribute.rb#17
    def __class_attr___callbacks=(new_value); end
  end
end

# source://tailwindcss-rails//lib/tailwindcss/version.rb#2
Tailwindcss::VERSION = T.let(T.unsafe(nil), String)
