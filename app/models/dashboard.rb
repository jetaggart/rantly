class Dashboard
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def my_rants
    user.rants
  end

  def latest_rants
    Rant.latest_for(user)
  end

  def mentions
    Rant.mentions_for(user)
  end
end
