module UserNavigationHelper
  def user_navigation_links
    links = []

    # Add links available to all users
    links << { name: "Home", path: root_path }
    links << { name: "Browse Products", path: root_path }

    # Add links for logged-in users
    if current_user && !current_user.is_a?(Guest)
      links << { name: "My Orders", path: orders_path }
      links << { name: "Log Out", path: destroy_user_session_path, method: :delete }
    end

    links
  end

  def side_nav_links
    links = []

    # Add links available to all users
    links << { name: "Home", path: root_path }
    links << { name: "Browse Products", path: root_path }

    # Add links for logged-in users
    if current_user && !current_user.is_a?(Guest)
      links << { name: "My Orders", path: orders_path }
      links << { name: "Log Out", path: destroy_user_session_path, method: :delete }
    else
      links << { name: "Sign In As User", path: new_user_session_path }
      links << { name: "Sign Up As User", path: new_user_registration_path }
    end

    links
  end

  def home_link
    {
      path: root_path,
      icon: "fa-brands fa-forumbee",
      title: "MarketHive"
    }
  end
end
