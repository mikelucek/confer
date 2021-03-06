class User < ActiveRecord::Base
	validates_numericality_of :phone
	validates_uniqueness_of :phone
	#user must be unique
	#user id must be saved in a standard way
	#cannot be empty
	#pin cannot be empty
	has_many :connections
	has_many :friends, :through => :connections
	# has_many :connecteds, :through => :connections
end
