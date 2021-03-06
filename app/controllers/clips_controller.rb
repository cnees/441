class ClipsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def show
    render json: Clip.find(params[:id])
  end

  def fave
    clip = Clip.find(params[:id])
    if (clip.faves)
      clip.faves += 1
    else
      clip.faves = 1
    end
    clip.save!
    render json: clip
  end

  def create
    clip = Clip.new(user_id: params[:user_id], data: params[:data], name: params[:name])
    if clip.save
      render json: clip, status: 201
    else
      render json: { errors: clip.errors }, status: 422
    end
  end
end