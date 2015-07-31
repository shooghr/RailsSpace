class UserMailer < ActionMailer::Base
  default from: "RailsSpace@example.com"

  def notificacao_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your login information at RailsSpace.com"  )
  end

  def message_email(mail)
  	@user = mail[:user]
  	@user_url = mail[:user_url]
  	@message = mail[:message] 
  	@reply_url = mail[:
  		reply_url]
  	mail(:to => mail[:recipient].email, :subject => mail[:message].subject, :body => mail[:message].body)
  end
end
