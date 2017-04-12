class User < ApplicationRecord
  has_many :recipe
  has_many :likes
  has_many :comments
  has_many :followings_within_oneself, class_name: 'Following', foreign_key: 'user_id'
  has_many :followers_within_oneself, class_name: 'Following', foreign_key: 'following_user_id'
  has_many :followings_within_oneself_users, through: :followings_within_oneself, source: 'following_user'

  after_create :follow_oneself

  def followings
    followings_within_oneself.without_oneself
  end

  def followers
    followers_within_oneself.without_oneself
  end

  private
  def follow_oneself
    self.followings_within_oneself.find_or_create_by!(following_user: self)
  end
end
