class GroupsController < ApplicationController
  def show
  	@group = Group.find(params[:id])
  end

  def index
  	@group = Group.all
  end
end
