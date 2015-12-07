class User < ActiveRecord::Base
  #has_many :clips
  has_many :clips, :through => :reposts
  has_many :reposts
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationships.find_or_create_by(followed_id: other_user.id)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def repost(clip)
    reposts.find_or_create_by(clip_id: clip)
  end

  def unrepost(clip)
    reposts.find_or_create_by(clip_id: clip).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end
end
