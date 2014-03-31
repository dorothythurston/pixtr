class ActivityMailer < ActionMailer::Base
  default from: "from@example.com"

  def activity_email(user, activity)
    @user = user
    @activity = activity
    mail(to: @user.email, subject: 'New Pixtr Activity')
  end
end
