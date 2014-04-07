class SearchesController < ApplicationController
  def index
    if params[:search]
      @results = find_images.order("created_at DESC").includes(gallery: [:user])
    else
      @results = Image.all.order('created_at DESC')
    end
  end

  private
  def find_images
    image_searcher = ImageSearcher.new(params[:search])
    image_searcher.images.includes(gallery: [:user])
  end
end
