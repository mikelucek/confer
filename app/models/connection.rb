class Connection < ActiveRecord::Base
	belongs_to :user
	# belongs_to :connected, :class_name => "User"
	belongs_to :friend, :class_name => "User"

end
