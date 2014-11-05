class AttendancesController < ApplicationController
  def create
    #user must be logged in
    if !logged_in?
      flash[:danger] = "Please Sign In"
      redirect_to sign_up_path
    end

    #Find the Group ID and have the user join the group
    group = Group.find(params[:group_id])
    temp = Attendance.new(group_id: group.id, user_id: current_user.id, status: "going",position: 0)
    if (Attendance.where(group_id: group.id).maximum("position") == nil)
      currposition = 0
    else
      currposition = Attendance.where(group_id: group.id).maximum("position")
    end

    
    if group.seats >0 #can't be less than zero
      temp.save
      temp.position = currposition+1
      temp.save
      
      group.seats = group.seats-1
      group.save

      organizer = User.find(group.user_id)
      #user gets karma 
      joinkarma(current_user,10)

      #organizer gets karma
      if organizer.id != current_user.id
        joinkarma(organizer,5)
      end
      flash[:success] = "You're In!" 

      #send look who's coming email
      joinemail(current_user,group)

    else
      group.seats = group.seats-1
      group.save
      flash[:warning] = "You're on the waitlist!"
      temp.status = "waitlisted"
      temp.position = currposition+1
      temp.save
    end
    
    redirect_to groups_path
  end

  def destroy
    currentAttendance = Attendance.find(params[:id])
    currentgroup = Group.find(currentAttendance.group_id)
    currentAttendance.destroy
    currentgroup.seats = currentgroup.seats+1
    currentgroup.save
    current_user.karma -= 11
    current_user.save

    flash[:danger] = "Cancelled" 
    redirect_to groups_path
  end

  private 

  def joinkarma(user,points)
    user.karma += points
    user.save
  end

  def joinemail(user,group)
    NotificationsMailer.joingroup_email(user, group).deliver
  end


end