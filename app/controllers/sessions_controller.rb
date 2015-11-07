class SessionsController < ApplicationController
	def new
		#login page
	end

	def create
		#sign in a user
		u = User.where(phone: params[:phone]).first
		if u

			if params[:pin] == u.pin
				session[:id] = u.id
				flash[:notice] = "Signed in with #{u.phone}"
				redirect_to members_root_path
			end
		else
	
			redirect_to new_session_path
		end
	end

	def destroy
		#log out
		session[:id] = nil
		redirect_to root_path
	end


end
