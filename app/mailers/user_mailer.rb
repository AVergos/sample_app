class UserMailer < ActionMailer::Base
  default :from => "vrgs.andreas@gmail.com"
  
  def registration_confirmation(user)
    @user = user
    @url = "http://stormy-rain-34.heroku.com/signin"
    mail(:to => user.email, :subject => "Registered")
  end
  
  def follow_confirmation(user)
    mail(:to => user.email, :subject => "Someone is following you!")
  end
  
  def unfollow_confirmation(user)
    mail(:to => user.email, :subject => "Someone no longer follows you :( ")
  end
end
