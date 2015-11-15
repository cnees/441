class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def feed
    id = params[:id]
    following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    render json: Clip.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id), :include => :user
  end

  def show_feed
    render :feed
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    user = User.new(username: params[:username])
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

end
  