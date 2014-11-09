class Event

  # this should not report in dev either, but it's a showcase app
  # so reporting in dev is useful
  def self.publish(*args)
    unless Rails.env.test? 
      Keen.publish(*args)
    end
  end
end
