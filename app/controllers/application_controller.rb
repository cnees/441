class ApplicationController < ActionController::Base
  skip_before_filter  :verify_authenticity_token

  def login
    if User.exists?(username: params[:username])
      user = User.find_by(username: params[:username])
      if user.password == Digest::SHA2.hexdigest(user.salt + params[:password])
        render json: user
      else
        render json: { :success => "false", :message => "Wrong password"}
      end
    else
      render json: { :success => "false", :message => "Incorrect username"}
    end
  end

  def unrepost
    user = User.find(params[:reposter_id])
    user.unrepost(params[:clip_id])
    redirect_to user
  end

  def unfollow
    user = User.find(params[:unfollow_id])
    User.find(params[:follower_id]).unfollow(user)
    redirect_to user
  end

  def popular
    render json: Clip.where("faves > 0").order("faves DESC").limit(15)
  end

  def feed
    render json: Clip.order("created_at DESC").limit(15), :include => :user
  end

  def search
    render json: Clip.where("name like ?", "%#{params[:query]}%")
  end
end
