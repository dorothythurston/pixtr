class GroupMembershipsController < ApplicationController
  def create
    @group = Group.find(params[:id])
    current_user.join @group
    notify(@group, @group, 'JoinGroupActivity')
    render :change
  end

  def destroy
    @group = Group.find(params[:id])
    current_user.leave @group
    render :change
  end
end
