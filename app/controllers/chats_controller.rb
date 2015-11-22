class ChatsController < ApplicationController; layout false
	def new
		Chat.create(user_id: params[:user_id], friend_id: params[:friend_id], message: params[:message])
	end

	def show
		current_user_or_sign_in
		f = find_my_friend(@user.id)
		@messages = Chat.where('(user_id=? and friend_id=?) or (user_id=? and friend_id=?)', @user.id, f, f, @user.id)

		#display all chats wih me/friend or friend/me. label each according to who is in the user_id field
		#in this version, we're going to load all of them each time, which doesn't scale	
	end
end
