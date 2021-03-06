class UserMailer < ActionMailer::Base
  
  def registration_confirmation(user)
    @user = user
    #@url = "http://stormy-rain-34.heroku.com/signin"
    mail(:to => user.email, :subject => "Registered", :from => "vrgs.andreas@gmail.com")
  end
  
  def follow_confirmation(user,current_user)
    @current_user = current_user
    mail(:to => user.email, :subject => "Someone is following you!", :from => current_user.email)
  end
  
  def unfollow_confirmation(user,current_user)
    @current_user = current_user
    mail(:to => user.email, :subject => "Someone no longer follows you :( ", :from => current_user.email)
  end
end
