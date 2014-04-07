class GalleriesController < ApplicationController
  respond_to :html
  before_filter :authorize, except: [:show]
  def index
    @galleries = current_user.galleries
  end

  def show
    @gallery= Gallery.find(params[:id])
    @images= @gallery.images.includes(gallery: [:user])
  end

  def new
    @gallery = Gallery.new
  end

  def create
    @gallery = current_user.galleries.new(gallery_params)
    if @gallery.save
      current_user.followers.each do |follower|
        current_user.notify_follower(@gallery, @gallery, 'CreateGalleryActivity')
      end
      redirect_to @gallery
    else
      render :new
     end
  end

  def edit
    @gallery = find_gallery
  end

  def update
    @gallery = find_gallery
    @gallery.update(gallery_params)
    respond_with @gallery
  end

  def destroy
    gallery = current_user.galleries.find(params[:id])
    gallery.destroy
    redirect_to root_path
  end

  private

  def gallery_params
    params.require(:gallery).permit(:name)
  end

  def find_gallery
    current_user.galleries.find(params[:id])
  end



end
