class Clip < ActiveRecord::Base
  belongs_to :user
  has_many :users, :through => :reposts
end