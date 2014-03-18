class Group < ActiveRecord::Base
  validates :name, presence: true
  has_many :group_memberships
  has_many :members, through: :group_memberships
end
