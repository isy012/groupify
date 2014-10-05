class Group < ActiveRecord::Base
  #has_many :attendances,  class_name: "Attendance",
  #                    foreign_key: "group_id",
  #                    dependent: :destroy
  has_many :attendances
  has_many :users, through: :attendances
end