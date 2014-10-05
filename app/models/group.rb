class Group < ActiveRecord::Base
  has_many :attendances,  class_name: "Attendance", foreign_key: "group_id", dependent: :destroy
  has_many :users, class_name: "Users", through: :attendances

  validates_numericality_of :seats, :only_integer => true, :greater_than_or_equal_to => 0 
end