class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		pin = text_pin_to_user(params[:user][:phone])

		if pin
			u = User.new(phone: params[:user][:phone], pin: pin, email: params[:user][:email])
			u.save
		end

		#attempt to send txt to the user
		#on success, save phone and pin to db
		#and redirect to session controller to ask user to sign in w pin
		redirect_to new_session_path
	end


	def forgot


		#if user already exists,
		#attempt to send txt to user
		#and redirect to session controller to ask user to sign in w pin
	end

	def resend
		n = params[:phone]
		u = User.where(phone: n).first
		if u
			pin = text_pin_to_user(n)
			u.update(pin: pin)
			flash[:notice] = "New PIN sent"
			redirect_to new_session_path
		end

	end

	def destroy
	end

	def text_pin_to_user(phone)
		#auth set in twilio.rb initializer
		#which pulls from secrets.yml
		r = rand(1000..9999)
		message = "Your PIN has been set to #{r}."
		@client = Twilio::REST::Client.new 
		message = @client.account.messages.create(
			:from => twilio_number,
			:to => phone,
			:body => message
		)

	puts message.to
	return r
	end



end
