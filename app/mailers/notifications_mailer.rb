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
    emails = find_emails_in_group(group)
  	mail to: 'groupmaster@usegroupify.com', bcc: emails, subject: 'Groupify! Someone has joined!'
  end

  def leavegroup_email(current_user,group)
    emails = find_emails_in_group(group)
    @current_user = current_user
    mail to: 'groupmaster@usegroupify.com', bcc: emails, subject: 'Groupify Cancellation'
  end

  private
  def find_usernames_in_group(group)
    @group = group
    #list of all attendance records
    attendance = Attendance.where(:group_id => @group.id)
    return attendance
  end

  def find_emails_in_group(group)
    @group = group

    attendance = Attendance.where(:group_id => @group.id)
    logger.info("ATTENDANCE" + attendance.inspect)
    emails = "" 
    for items in attendance 
      emails = emails + ", " + User.find(items.user_id).email.to_str
    end
    return emails

  end


end