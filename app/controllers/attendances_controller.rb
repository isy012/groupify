class AttendancesController < ApplicationController
  def create
  	group = Group.find(params[:group_id])
    logger.debug "HELLOWORLD: #{current_user.inspect}"
    #logger.debug "User: #{current_user.attributes.inspect}"
  	#current_user.claim(group)
  	redirect_to root_url
  end

  def destroy
  	group = Group.find(params[:group_id])
  	@current_user.cancel(group)
  	redirect_to current_user
  end

end