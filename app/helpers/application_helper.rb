# coding: utf-8
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
    if user.followed_by?(current_user)
      text   = "Unfollow"
      path   = following_path(current_user.following_for(user))
      method = :delete
    else
      text   = "Follow"
      path   = followings_path(:following_id => user)
      method = :post
    end

    link_to(text, path, :method => method, :class => "quicklink", :remote => true)
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
            :class  => "quicklink",
            :remote => true)
  end

  def sort_link(text, direction)
    new_direction, caret = if direction.nil? || direction == "DESC"
                             ["ASC", "▼"]
                           else
                             ["DESC", "▲"]
                           end


    link_to "#{text} #{caret}", "#{request.path}?sort=#{new_direction}"
  end

  def disable_link(user)
    text, method = if user.disabled?
                     ["Enable", :delete]
                   else
                     ["Disable", :post]
                   end

    link_to text, disable_admin_user_path(user), :method => method
  end

  def errors_for(form)
    return unless form.object.errors.present?

    render :partial => "shared/form_errors", :locals => {:form => form}
  end
end
