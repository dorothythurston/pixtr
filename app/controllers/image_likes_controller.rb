class ImageLikesController < ApplicationController
  def create
    @image = Image.find(params[:id])
    like = current_user.like @image
    notify_follower(like, @image, 'LikeActivity')
    render :change
  end

  def destroy
    @image = Image.find(params[:id])
    current_user.unlike @image
    render :change
  end
end
