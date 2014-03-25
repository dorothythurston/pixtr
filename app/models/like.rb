class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true
  belongs_to :user

  has_many :activities, as: :subject, dependent: :destroy

  validates :user, presence: true,
    uniqueness: { scope: [:likeable_id, :likable_type] }
  validate :likable, presence: true
end
