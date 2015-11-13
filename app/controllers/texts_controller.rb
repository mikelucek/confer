class TextsController < ApplicationController; layout false
  def setup
  	# on incoming txt, check for user.
  	# if no user, send error txt.
  	# if user, check for friendship.
  	# if no friendship, send error txt.
  	# if friendship, 
  	# 	check for special text, like /UNLINK
  	# 	to destroy friendship.
  	# else
  	# 	find friend's phone number.
  	# 	forward the txt.
    from = params['From'][-10, 10]
    body = params['Body']
    user = User.where(phone: from).first
    if user.nil?
      message = "(*Confer*) You do not have an account on the service."
      sms_message(message, from)
    else
      friend = find_my_friend(user.id)
      if !friend.nil?
        sms_message(body, friend.phone)
      else
        message = "(*Confer*) You do not currently have a buddy on the system."
        sms_message(message, from)
      end
    end

  end
end
