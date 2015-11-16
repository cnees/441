class Repost < ActiveRecord::Base
  has_many :users
  has_many :clips
end
