# frozen_string_literal: true

class Components::Base < Phlex::HTML
  include Components

  CACHE = Phlex::FIFOCacheStore.new(
    max_bytesize: 20_000_000
  )

  # Include any helpers you want to be available across all components
  include Phlex::Rails::Helpers::Routes

  if Rails.env.development?
    def before_template
      comment { "Before #{self.class.name}" }
      super
    end
  end

  def cache_store
    Rails.cache
  end
end
