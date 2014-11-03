class HomeController < ApplicationController
  def index
    if flash.empty? && session.delete(:visited)
      flash.now[:notice] = "Welcome back! Consider joining."
    end

    session[:visited] = true
  end
end
