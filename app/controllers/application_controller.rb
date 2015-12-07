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

end
