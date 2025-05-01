# frozen_string_literal: true

module Components
  class StoreCardComponent < Components::Base
    include Phlex::Rails::Helpers::ImageTag

    # Initialize with a store parameter
    def initialize(store:)
      raise "store must be a Store Active Model record!" unless store.is_a?(Store)
      @store = store
    end

    # The main template method that renders the component
    def view_template
      cache(@store) do
        a(href: store_path(@store.id)) do
          div(class: "bg-white shadow-md rounded-xl overflow-hidden transition-transform hover:scale-105 hover:shadow-lg") do
            render_image_section
            render_info_section
          end
        end
      end
    end

    private

    # Render the image section of the card
    def render_image_section
      div(class: "relative w-full h-48 overflow-hidden") do
        if @store.spotlight.attached?
          img(src: helpers.url_for(@store.spotlight.variant(:thumb)),
              class: "w-full h-full object-cover object-center")
        else
          div(class: "w-full h-full bg-gray-200 flex items-center justify-center") do
            svg(xmlns: "http://www.w3.org/2000/svg",
                class: "h-16 w-16 text-gray-400",
                fill: "none",
                viewbox: "0 0 24 24",
                stroke: "currentColor") do
              path(stroke_linecap: "round",
                  stroke_linejoin: "round",
                  stroke_width: "1.5",
                  d: "M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z")
            end
          end
        end
      end
    end

    # Render the information section of the card
    def render_info_section
      div(class: "p-4 bg-gradient-to-r from-indigo-600 to-purple-600 text-white") do
        h3(class: "text-lg font-semibold mb-2 truncate") { @store.name }
        a(href: store_path(@store),
          class: "mt-1 bg-white text-indigo-700 rounded-md px-4 py-1.5 inline-block font-medium hover:bg-gray-100 transition-colors focus:ring-2 focus:ring-white focus:ring-offset-2 focus:ring-offset-indigo-600 focus:outline-none") do
          "Shop Now"
        end
      end
    end
  end
end
