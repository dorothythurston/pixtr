class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images
  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true
  has_many :likes, as: :likable, dependent: :destroy

  has_many :user_likes, through: :likes, source: :user

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tag_list

  def tag
    @image.tag_list.add
  end

  def user
    gallery.user
  end
end
