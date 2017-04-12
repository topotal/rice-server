class Recipe < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :comments
  has_many :steps, dependent: :destroy
  has_many :ingredients, dependent: :destroy

  DEFAULT_COUNT = 20

  scope :subscribed_by_user, -> (user) {
    joins(:user).merge(user.followings_within_oneself_users)
  }
end
