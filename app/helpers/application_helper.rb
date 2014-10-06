module ApplicationHelper
  def nav_link(text, path)
    options = if path == request.path
                {:class => "current"}
              else
                {}
              end
    link_to text, path, options
  end

  def follow_link(user)
    if user.followed_by? current_user
      link_to "Unfollow",
              following_path(current_user.following_for(user)),
              :method => :delete
    else
      link_to "Follow",
              followings_path(:following_id => user),
              :method => :post
    end
  end
end
