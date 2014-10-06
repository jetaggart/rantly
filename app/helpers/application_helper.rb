module ApplicationHelper
  def nav_link(text, path)
    options = if path == request.path
                {:class => "current"}
              else
                {}
              end
    link_to text, path, options
  end
end
