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
    
    redirect_to current_user
  end

  def destroy
    #Find group id by user id
    currentgroup = Attendance.find(params[:id]).group
    #Find attendance id by user id
    currentAttendance = Attendance.find_by(params[:user_id])
    currentAttendance.destroy
    currentgroup.seats = currentgroup.seats+1
    currentgroup.save
    NotificationsMailer.welcome_email().deliver
    flash[:danger] = "Cancelled" 
    redirect_to current_user
  end

end