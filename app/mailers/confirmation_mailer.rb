class ConfirmationMailer < ActionMailer::Base
  default :from => "admin@rantly.com"
  
  def confirmation_email(user)
    @token = user.confirmation_token
    mail(:to => user.email, :subject => "Thanks for signing up!")
  end
end
