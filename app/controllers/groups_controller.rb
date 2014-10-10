class GroupsController < ApplicationController
  def show
  	@group = Group.find(params[:id])
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @group }
      format.json { render :json => @group }
    end
  end

  def index
  	@group = Group.all

  end
end