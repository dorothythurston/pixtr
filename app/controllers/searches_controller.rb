class SearchesController < ApplicationController
  def index
    if params[:search]
      @results = Image.search(params[:search]).order("created_at DESC").includes(gallery: [:user])
    else
      @results = Image.all.order('created_at DESC')
    end
  end
end
