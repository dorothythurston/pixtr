class User < ActiveRecord::Base

  include Clearance::User

  has_many :activities
  has_many :likes, dependent: :destroy

  has_many :liked_images, through: :likes, source: :likable, source_type: 'Image'

  has_many :liked_galleries, through: :likes, source: :likable, source_type: 'Gallery'

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

  def notify_follower(subject, type)
    followers.each do |follower|
      follower.activities.create(
        subject: subject,
        type: type)
    end
  end

  def follow(user)
    follow = followed_user_relationships.create(followed_user: user)
    notify_follower(follow, 'FollowUserActivity')
  end

  def following?(user)
    followed_user_ids.include? user.id
  end

  def unfollow(user)
    followed_users.destroy user
  end

  def join(group)
    join_group = group_memberships.create(group: group)
    notify_follower(join_group, 'JoinGroupActivity')
  end

  def member?(group)
    group_ids.include? group.id
  end

  def leave(group)
    groups.destroy group
  end

  def liked?(target)
    likes.exists?(likable: target)
  end

  def like(target)
    like = likes.create(likable: target)
    notify_follower(like, 'LikeActivity')
  end

  def unlike(target)
    likes.find_by(likable: target).destroy
  end
end
