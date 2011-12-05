class UserMailer < ActionMailer::Base
  default :from => "no-reply@cheq.it"

  def welcome_email(user)
  	@user = user
  	@url = "http://cheq.it/login"
  	mail(:to => user.email, :subject => "Welcome to Cheqit")
  end

  def match_email(user, matchee)
  	@user = user
  	@matchee = matchee
  	mail(:to => user.email, :subject => "You have a Match!")
  end
end