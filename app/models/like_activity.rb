class LikeActivity < Activity
  def image
    subject.image
  end

  def image_name
    image.name
  end

  def email
    subject.image.user.email
  end
end
