class FollowerNotifier
  def initialize(user)
    @user = user
  end

  def notify_follower(subject, target, type)
    if subject.persisted?
      user.followers.each do |follower|
        follower.activities.create(
          subject: subject,
          type: type,
          actor: user,
          target: target)
        mail(follower, subject)
      end
    end
  end
  handle_asynchronously :notify_follower

  def mail(followers, subject)
    ActivityMailer.activity_email(follower, subject)
  end
  handle_asynchronously :mail

  private

  attr_reader :user
end

