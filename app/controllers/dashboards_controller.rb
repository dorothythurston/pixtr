class DashboardsController < ApplicationController
  def show
    @activities = current_user.activities.includes(:actor, :target)
  end
end
