class Group < ActiveRecord::Base
  has_many :attendances,  class_name: "Attendance", foreign_key: "group_id", dependent: :destroy
  has_many :users, class_name: "Users", through: :attendances
  has_one :user

  validates_numericality_of :seats, :only_integer => true 
  validates(:when, 	presence: true)
end