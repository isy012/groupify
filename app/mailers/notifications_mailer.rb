class NotificationsMailer < ActionMailer::Base
  default from: 'groupmaster@usegroupify.com'

  def welcome_email(current_user)
  	@user = current_user
  	mail to: @user.email, subject: 'Welcome to Groupify'
	end

  def joingroup_email(current_user, group)
  	@user = current_user
    @group = group
  	@attending = find_usernames_in_group(group)

  	mail to: current_user.email, subject: 'Someone has joined the group'
  end

  private
  def find_usernames_in_group(group)
    @group = group
    #list of all attendance records
    attendance = Attendance.where(:group_id => @group.id)
    return attendance
  end

end