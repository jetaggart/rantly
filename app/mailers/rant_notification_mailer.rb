class RantNotificationMailer < ActionMailer::Base
  default :from => "admin@rantly.com"
  
  def rant_notification_email(rant, user)
    @rant = rant
    mail(:to => user.email, :subject => "#{rant.author.full_name} has posted a rant")
  end
end
