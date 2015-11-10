class MembersController < ApplicationController
  def index
  	#main landing page
  	current_user_or_sign_in
  	@c = Conference.where(user_id: session[:id]).last
  	if !@c.nil?
  		@conference = @c.conference_description
  	else
  		@conference = "You are not signed up for a conference"
  	end
  	@f = find_my_friend(session[:id])
  	if !@f.nil?
  		@friend = "You have a friend for this session"
  	else
  		@friend = "You do not yet have a friend for this session"
  	end
  
  end

  def search
  	#search for conferences
  	current_user_or_sign_in
  
  end

  def results
  	#show list of searched conferences
  	current_user_or_sign_in
  	if !params[:place].blank? && !params[:topic].blank?
  		 #http://lanyrd.com/topics/startups/in/usa/feed/
  		 url = "http://lanyrd.com/topics/#{params[:topic]}/in/#{params[:place]}/feed/"
  		 parser url

  	elsif params[:place] && params[:topic].blank?
  		#http://lanyrd.com/places/brighton/feed/
  		url = "http://lanyrd.com/places/#{params[:place]}/feed/"
  		parser url

  	elsif params[:topic] && params[:place].blank?
  		#http://lanyrd.com/topics/nodejs/feed/
  		url = "http://lanyrd.com/topics/#{params[:topic]}/feed/"
  		parser url

  	else
  		@feed = nil
  	end
  end

  def parser (url)
  	  	begin
  			@feed = Feedjira::Feed.fetch_and_parse url
  		rescue StandardError
			@feed = nil
  		end
  end

#########################

def conference_signup
	current_user_or_sign_in

	#the new conference you picked:
	conference_id = params[:conference_id]
	conference_title = params[:conference_title]

	#let's record it.
	Conference.create(user_id: @user.id, conference_id: conference_id, conference_description: conference_title)


	#if we have a previous friendship, let's get rid of it. Current user could be on either side of a connection, so let's check both sides: 
	a = Connection.where("user_id = ? or friend_id = ?", @user.id, @user.id).first
	if a
		recipient = User.find(a.user_id)
		sms_message("You have been unlinked", recipient.phone)
		recipient = User.find(a.friend_id)
		sms_message("You have been unlinked", recipient.phone)
		a.destroy
	end

	#let's see if anyone else is going to the same conference we are
	all_other_conference_goers = Conference.where.not(user_id: @user.id)
	same_conference_goers = all_other_conference_goers.where(conference_id: conference_id)

	#let's find the first one of those (if any) who aren't matched
	same_conference_goers.each do |x|

		a = Connection.where("user_id = ? or friend_id = ?", x.user_id, x.user_id)
		if a.empty?
			Connection.create(user_id: @user.id, friend_id: x.user_id)
			recipient = User.find(x.user_id)
			sms_message("You have been linked!", recipient.phone)
			sms_message("You have been linked!", @user.phone)
			flash[:notice] = "You have been linked!"
			break
		end
	end



	redirect_to members_root_path
end

  # browse conferences from lanyard based on search.
  # choosing one 
  # destroys current friendship if there is one
  # adds the conference id and summary to my user acct.
  # searches all other user accts for the same conf id
  # creates the friendship if it finds a match
  # txts both parties to inform them of the connection





end