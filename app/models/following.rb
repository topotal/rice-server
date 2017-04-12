class Following < ApplicationRecord
  belongs_to :user
  belongs_to :following_user, class_name: 'User'

  validates :following_user_id, uniqueness: { scope: [:user_id] }

  scope :without_oneself, -> { where('followings.user_id <> followings.following_user_id') }
end
