class HomesController < ApplicationController
  before_action :goto_dashboard

  def show
  end

  private
  def goto_dashboard
    if signed_in?
    redirect_to dashboard_path
    end
  end
  
end
