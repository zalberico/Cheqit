ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => "Cheq.it",
  :user_name            => "cheqitemailer",
  :password             => "cheqitemailer",
  :authentication       => "plain",
  :enable_starttls_auto => true
}