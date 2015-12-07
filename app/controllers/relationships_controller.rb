class RelationshipsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    user = User.find(params[:followed_id])
    User.find(params[:follower_id]).follow(user)
    redirect_to user
  end
end