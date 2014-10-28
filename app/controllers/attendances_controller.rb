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
      current_user.karma += 10
      current_user.save
      organizer = User.find(group.user_id)
      if organizer.id != current_user.id
        organizer.karma += 5
        organizer.save
      end
      flash[:success] = "You're In!" 
      #NotificationsMailer.welcome_email(current_user).deliver
      NotificationsMailer.joingroup_email(current_user, group).deliver
    else
      flash[:danger] = "Sorry, that group is full :("
    end
    
    redirect_to current_user
  end

  def destroy
    currentgroup = Attendance.find(params[:id]).group
    #destroy only the current user's id
    currentAttendance = Attendance.find_by(:group_id => currentgroup.id, :user_id => current_user.id)
    currentAttendance.destroy
    currentgroup.seats = currentgroup.seats+1
    currentgroup.save
    current_user.karma -= 11
    current_user.save

    flash[:danger] = "Cancelled" 
    redirect_to current_user
  end

end