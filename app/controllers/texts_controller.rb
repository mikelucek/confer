class TextsController < ApplicationController
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

  end
end
