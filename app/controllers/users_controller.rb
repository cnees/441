class UsersController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def feed
    id = params[:id]
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    clip_ids = "SELECT clip_id FROM reposts WHERE user_id IN (#{following_ids})"
    
    render json: Clip.where("(user_id IN (#{following_ids})
                         OR user_id = :user_id OR id IN (#{clip_ids}))", user_id: id), :include => :user
    
  end

  def login
    if User.exists?(params[:id])
      u = User.find(params[:id])
      if u.password == Digest::SHA2.hexdigest(u.salt + params[:password])
        render json: { :success => "true", :message => "Login successful"}
      else
        render json: { :success => "false", :message => "Wrong password"}
      end
    else
      render json: { :success => "false", :message => "Incorrect username"}
    end
  end

  def show_feed
    render :feed
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

end