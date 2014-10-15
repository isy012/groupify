class AttendancesController < ApplicationController
  def create
    if !logged_in?
      flash[:danger] = "Please Sign In"
      redirect_to sign_up_path
    end
    group = Group.find(params[:group_id])
    temp = Attendance.new(group_id: group.id, user_id: current_user.id)
    #temp.save #record it
    #group.seats = group.seats-1 #decrement seats
    if group.seats-1 >=0 #can't be less than zero
      temp.save
      group.seats = group.seats-1
      group.save
      flash[:success] = "You're In!" 
    else
      flash[:danger] = "Sorry, that group is full :("
    end
    
    redirect_to groups_path
  end

  def destroy
    #the current user's group id
    #currentgroup = Group.find_by(params[:group_id])
    currentgroup = Attendance.find(params[:id]).group
    #destroy only the current user's id
    currentAttendance = Attendance.find_by(:group_id => currentgroup.id, :user_id => current_user.id)
    #currentAttendance = Attendance.find_by(params[:id])
    logger.debug "current attendance is: #{currentAttendance.attributes.inspect}"
    currentAttendance.destroy
    currentgroup.seats = currentgroup.seats+1
    currentgroup.save
    #NotificationsMailer.welcome_email().deliver
    flash[:danger] = "Cancelled" 
    redirect_to groups_path
  end

end