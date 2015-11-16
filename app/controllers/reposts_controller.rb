class RepostsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    user = User.find(params[:reposter_id])
    user.repost(params[:clip_id])
    redirect_to Clip.find(params[:clip_id])
  end
end
