class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params) #send hash of user attribute
    @user.karma = 0
    if @user.save
      log_in @user
      flash[:success] = "You've signed Up"
  	  redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
   # @user = User.find(params[:id])
  end

  def show
  	#@user = User.find(params[:id])
    @group = Group.order('created_at DESC').all
    @attendance = Attendance.all
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  private

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
    end

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :karma)
    end

    # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end