class NotificationsMailer < ActionMailer::Base
  default from: 'groupmaster@usegroupify.com'

  def welcome_email()
  	#@user = current_user
  	#mail to: 'isabelle.y.park@gmail.com', subject: 'Welcome to my wonderful website'
	mail(:to => 'ipark012@yahoo.com', :subject => 'Sup')  
  end

end
