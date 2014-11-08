class UserSession
  extend ActiveModel::Naming
  include ActiveModel::Validations

  validate :not_disabled
  validate :confirmed

  attr_accessor :username, :password, :session, :user

  def initialize(options = {})
    self.username = options[:username]
    self.password = options[:password]
    self.session  = options.fetch(:session)
    self.user     = User.find_by(:username => username)
  end

  def save
    if user.present? && user.authenticate(password)
      valid? && login!
    else
      errors.add(:base, "Login failed")
      false
    end
  end

  def to_key
    ["user_session"]
  end

  private

  def login!
    session[:user_id] = user.id
  end

  def not_disabled
    if user.disabled?
      errors.add(:base, "Account is disabled")
    end
  end

  def confirmed
    unless user.confirmed?
      errors.add(:base, "You must confirm your account")
    end
  end

end
