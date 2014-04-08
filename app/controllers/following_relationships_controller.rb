class FollowingRelationshipsController < ApplicationController
  def create
    followed_user  = User.find(params[:id])
    follow =  current_user.follow followed_user
    notify(follow, followed_user, 'FollowUserActivity')
    redirect_to followed_user
  end

  def destroy
    followed_user  = User.find(params[:id])
    current_user.unfollow followed_user
    redirect_to followed_user
  end
end
