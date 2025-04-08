module ApplicationHelper
  include Pagy::Frontend

  def display_username
    if store_admin_signed_in?
      current_store_admin.email
    elsif user_signed_in?
      current_user.email
    else
      "Guest"
    end
  end

  def user_type
    if current_store_admin
      "store_admin"
    else
      "user"
    end
  end

  # Helper for creating sortable column headers
  def sortable_column(column, title = nil)
    title ||= column.titleize
    css_class = column == params[:sort] ? "text-indigo-800 font-bold" : "text-gray-500"
    direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"

    # Generate the sorting icon based on current sort state
    sort_icon = if column == params[:sort]
      direction == "asc" ? "↑" : "↓"
    else
      "↕"
    end

    link_to(
      "#{title} #{sort_icon}",
      request.params.merge(sort: column, direction: direction),
      class: "#{css_class} cursor-pointer hover:text-indigo-600 flex items-center"
    )
  end
end
