class Gram < ActiveRecord::Base
	# check is message is present
	validates :message, presence: true
end
