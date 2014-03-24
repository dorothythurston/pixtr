class Image < ActiveRecord::Base
  belongs_to :gallery
  has_many :comments, dependent: :destroy

  has_many :group_images, dependent: :destroy
  has_many :groups, through: :group_images
  validates :name, presence: true
  validates :description, presence: true
  validates :url, presence: true
  has_many :likes, dependent: :destroy

  has_many :user_likes, through: :likes, source: :user

  def user
    gallery.user
  end
end
