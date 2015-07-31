class UserMailer < ActionMailer::Base
  default from: "RailsSpace@example.com"

  def notificacao_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your login information at RailsSpace.com"  )
  end

  def message_email(mail)
  	@mail = mail
  	mail(:to => mail[:recipient].email, :subject => mail[:message].subject, :body => mail)
  end
end
