ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  #:domain               => 'gmail.com',
  :user_name            => 'vrgs.andreas@gmail.com',
  :password             => 'Vg6+5+4+3',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
