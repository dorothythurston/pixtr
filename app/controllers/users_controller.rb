class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @groups = @user.groups
    @images = @user.images.includes(gallery: [:user])
  end
end
