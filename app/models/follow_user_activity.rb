class FollowUserActivity < Activity
  delegate :followed_user, to: :subject

  def followed_user_name
    followed_user.email
  end

  def email
    followed_user.email

  end
end
