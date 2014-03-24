

class User < ActiveRecord::Base

  include Clearance::User

  has_many :activities
  has_many :likes, dependent: :destroy

  has_many :liked_images, through: :likes, source: :image

  has_many :galleries, dependent: :destroy
  has_many :images, through: :galleries

  has_many :group_memberships, foreign_key: :member_id, dependent: :destroy
  has_many :groups, through: :group_memberships

  has_many :followed_user_relationships,
    foreign_key: :follower_id,
    class_name: "FollowingRelationship",
    dependent: :destroy
  has_many :followed_users, through: :followed_user_relationships

  has_many :follower_relationships,
    foreign_key: :followed_user_id,
    class_name: "FollowingRelationship",
    dependent: :destroy

  has_many :followers, through: :follower_relationships

  def follow(user)
    follow = followed_user_relationships.create(followed_user: user)

    followers.each do |follower|
      follower.activities.create(
        subject: follow,
        type: 'FollowUserActivity')
    end
  end

  def following?(user)
    followed_user_ids.include? user.id
  end

  def unfollow(user)
    followed_users.destroy user
  end

  def join(group)
    join_group = group_memberships.create(group: group)

    followers.each do |follower|
      follower.activities.create(
        subject: join_group,
        type: 'JoinGroupActivity')
    end
  end

  def member?(group)
    group_ids.include? group.id
  end

  def leave(group)
    groups.destroy group
  end

  def liked?(image)
    liked_image_ids.include? image.id
  end

  def like(image)
    like = likes.create(image: image)

    followers.each do |follower|
      follower.activities.create(
        subject: like,
        type: 'LikeActivity')

    end
  end

  def unlike(image)
    liked_images.destroy image
  end
end
