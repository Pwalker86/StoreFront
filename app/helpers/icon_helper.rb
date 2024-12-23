module IconHelper
 def icon(name, css: nil)
    file_path = File.read(Rails.root.join("app", "assets", "images", "svg", "#{name}.svg"))
    svg_file = Nokogiri::HTML::DocumentFragment.parse(file_path).at_css("svg")

    svg_file["class"] = css

    svg_file.to_html.html_safe
  end
end
