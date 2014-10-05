class Attendance < ActiveRecord::Base
	#belongs_to :user, class_name: "User"
	#belongs_to :group, class_name: "Group"
	belongs_to :user
	belongs_to :group
	validates :user_id, presence: true
	validates :group_id, presence: true
end