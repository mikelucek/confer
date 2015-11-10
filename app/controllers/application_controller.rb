class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def twilio_number
  	if Rails.application.secrets.twilio_number
  		@twilio_number = Rails.application.secrets.twilio_number
  	end
  end

  def find_my_friend(user_id)
  	a = Connection.where(user_id: user_id).first
  	if !a.nil?
  		return User.find(a.friend_id)
  	end
  	b = Connection.where(friend_id: user_id).first
  	if !b.nil?
  		return User.find(b.user_id)
  	end
  	return nil
  end

  def current_user_or_sign_in
	if session[:id]
		@user = User.find(session[:id])
	else
		redirect_to new_session_path
	end

end

def sms_message(message, phone)
	@client = Twilio::REST::Client.new 
		message = @client.account.messages.create(
			:from => twilio_number,
			:to => phone,
			:body => message
		)

	puts message.to
end

  
end
