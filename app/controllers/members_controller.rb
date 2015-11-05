class MembersController < ApplicationController
  def index
  
  end

  def search
  
  end

  def results
  	if !params[:place].blank? && !params[:topic].blank?
  		 #http://lanyrd.com/topics/startups/in/usa/feed/
  		 url = "http://lanyrd.com/topics/#{params[:topic]}/in/#{params[:place]}/feed/"
  		 @feed = Feedjira::Feed.fetch_and_parse url

  	elsif params[:place] && params[:topic].blank?
  		#http://lanyrd.com/places/brighton/feed/
  		url = "http://lanyrd.com/places/#{params[:place]}/feed/"
  		@feed = Feedjira::Feed.fetch_and_parse url

  	elsif params[:topic] && params[:place].blank?
  		#http://lanyrd.com/topics/nodejs/feed/
  		url = "http://lanyrd.com/topics/#{params[:topic]}/feed/"
  		@feed = Feedjira::Feed.fetch_and_parse url

  	else
  		@feed = nil
  	end
  end



  # browse conferences from lanyard based on search.
  # choosing one 
  # destroys current friendship if there is one
  # adds the conference id and summary to my user acct.
  # searches all other user accts for the same conf id
  # creates the friendship if it finds a match
  # txts both parties to inform them of the connection
end


def current_user
	if session[:id]
		@user = User.find(session[:id])
		@user.phone
	end
end