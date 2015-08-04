class UserMailer < ActionMailer::Base
  default from: "RailsSpace@example.com"

  def notificacao_email(user)
  	@user = user
  	mail(:to => user.email, :subject => "Your login information at RailsSpace.com"  )
  end

  def message_email(mail)
  	@user      = mail[:user]
  	@user_url  = mail[:user_url]
  	@message   = mail[:message] 
  	@reply_url = mail[:reply_url]
  	mail(:to => mail[:recipient].email, :subject => mail[:message].subject, :body => mail[:message].body)
  end

  def friend_request(mail)
    @user        = mail[:user]
    @friend      = mail[:friend]
    @user_url    = mail[:user_url] 
    @accept_url  = mail[:accept_url]
    @decline_url = mail[:decline_url]
    mail(:to => mail[:friend].email, :subject => "New friend request at RailsSpace.com")
  end

end
