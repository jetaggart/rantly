class UserSession
  extend ActiveModel::Naming

  attr_accessor :username, :password, :session, :user

  def initialize(options = {})
    self.username = options[:username]
    self.password = options[:password]
    self.session  = options[:session]
    self.user     = User.find_by(:username => username)
  end

  def save
    if user.present? && user.authenticate(password)
      session[:user_id] = user.id
    else
      false
    end
  end

  def to_key
    ["user_session"]
  end
end
