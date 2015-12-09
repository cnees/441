class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def feed
    id = params[:id]
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    clip_ids = "SELECT clip_id FROM reposts WHERE user_id IN (#{following_ids})"
    
    render json: Clip.where("(user_id IN (#{following_ids})
                         OR user_id = :user_id OR id IN (#{clip_ids}))", user_id: id).order('created_at DESC').limit(15), :include => :user
  end

  def show_feed
    render :feed
  end

  def user_posts
    id = params[:id]
    render json: Clip.where(user_id: id).order('created_at DESC').limit(15), :include => :user
  end

  def show
    render json: User.find(params[:id])
  end

  def create
    salt = ('a'..'z').to_a.shuffle[0,8].join
    password = Digest::SHA2.hexdigest(salt + params[:password])
    user = User.new(username: params[:username], salt: salt, password: password, email: params[:email])
    if user.save
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def followers
    render json: User.find(params[:id]).followers
  end

  def following
    render json: User.find(params[:id]).following
  end
end