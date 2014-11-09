class Event

  # this should not report in dev either, but it's a showcase app
  # so reporting in dev is useful
  def self.publish(*args)
    return if Rails.env.test?

    Keen.publish(*args)
  end

  def self.logins_today
    return [] if Rails.env.test?

    Keen.extraction("logins", :timeframe => "today")
  end
end
