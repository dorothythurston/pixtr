class ImagesController < ApplicationController
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @image = Image.new
  end

  def create
    gallery = Gallery.find(params[:gallery_id])
    image = gallery.images.create(image_params)
    redirect_to gallery
  end

  def show
    @image = Image.find(params[:id])
    @gallery = @image.gallery
  end

   def edit
    @image = Image.find(params[:id])
  end

  def update
    image = Image.find(params[:id])
    image.update(image_params)
    redirect_to image
  end

  def destroy
    image = Image.find(params[:id])
    image.destroy
    redirect_to image.gallery
  end

private

  def image_params
    params.require(:image).permit(
      :name, 
      :url, 
      :description)
  end
end
