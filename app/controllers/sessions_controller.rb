class SessionsController < ApplicationController
	def new
	end

	def create
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


end
