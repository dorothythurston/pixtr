class ApplicationController < ActionController::Base
  include Clearance::Controller
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def notify(subject, target, type)
    FollowerNotifier.new(current_user).notify_follower(subject, target, type)
  end
end
