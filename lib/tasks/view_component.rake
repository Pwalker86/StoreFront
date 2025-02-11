namespace :view_component do
  desc "Generate a new view component"
  task :generate do
    options = {
      name: ENV["name"]
    }

    if options.values.all?(&:nil?)
      puts "Usage: rake do_some_action:run name=your_component_name"
      next
    end

    raise ArgumentError, "name is required" if options[:name].blank?

    sh("rails generate component #{options[:name]} --preview")
  end
end
