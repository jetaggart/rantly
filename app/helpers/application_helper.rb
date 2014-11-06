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

  def favorite_link(rant)
    if rant.favorited_by?(current_user)
      text   = "Unfavorite"
      path   = rant_favorite_path(rant, current_user.favorite_for(rant))
      method = :delete
    else
      text   = "Favorite"
      path   = rant_favorites_path(rant)
      method = :post
    end

    link_to("#{rant.favorite_count} - #{text}",
            path,
            :method => method,
            :class  => "favorite",
            :remote => true)
  end

  def errors_for(form)
    return unless form.object.errors.present?

    render :partial => "shared/form_errors", :locals => {:form => form}
  end
end
