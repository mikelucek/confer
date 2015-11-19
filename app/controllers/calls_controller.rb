class CallsController < ApplicationController; layout false
  def setup


  	from = params['From'][-10, 10]

  	user = User.where(phone: from).first
  	if user.nil?
  		 @call_response = Twilio::TwiML::Response.new do |r|
  		 	r.Say 'Hello.'
  		 	r.Say 'You do not currently have an account with us.'
  		 	r.Say 'Please visit our website in order to sign up.'
  		 end.text
  		 render xml: @call_response
  	else
  	 	friend = find_my_friend(user.id)
  	 	if !friend.nil?
  			@call_response = Twilio::TwiML::Response.new do |r|
  			r.Dial :callerId => "+12154909443" do |d|
  				d.Number friend.phone
  				end
  			end.text
  			render xml: @call_response
  		else
  			@call_response = Twilio::TwiML::Response.new do |r|
  				r.Say "Hello."
  				r.Say "You do not currently have a buddy on the system."
  				r.Say "Please visit our website in order to find a buddy."
  			end.text
  			render xml: @call_response
  		end
  	end
  
  end
end

