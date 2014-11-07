class UserSession
  extend ActiveModel::Naming
  include ActiveRecord::Validations

  attr_accessor :username, :password, :session, :user

  def initialize(options = {})
    self.username = options[:username]
    self.password = options[:password]
    self.session  = options.fetch(:session)
    self.user     = User.find_by(:username => username)
  end

  def save
    if user.present? && user.authenticate(password)
      if user.disabled?
        errors.add(:base, "Account is disabled")
        false
      else
        session[:user_id] = user.id
        true
      end
    else
      errors.add(:base, "Login failed")
      false
    end
  end

  def to_key
    ["user_session"]
  end
end
