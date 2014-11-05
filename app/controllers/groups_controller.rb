class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @group = Group.order('created_at DESC').all
    @user = User.all
    @attendance = Attendance.all
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    
    #check to see if user has more than 5 events
    if Group.where("user_id = ?", current_user.id).count <= 20
      @group.user_id = current_user.id  
      current_user.karma += 10
    else
      #overloaded
      flash.now[:danger] = 'User Has Too Many Groups Created' # Not quite right!
      render :action => 'new'
      return
    end

    respond_to do |format|
      if @group.save
        current_user.save
        #first user
        temp = Attendance.new(group_id: @group.id, user_id: current_user.id, status: "going", position: 1)
        temp.save
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render action: 'show', status: :created, location: @group }
      else
        format.html { render action: 'new' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to current_user }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find_by_id(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:title, :content, :seats, :when)
    end

end
