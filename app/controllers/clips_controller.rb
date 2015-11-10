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
    render json: clip, status: 204
  end

  def create
    puts "creating"
    puts clip_params
    clip = Clip.new(clip_params)
    puts "created"
    if clip.save
      render json: clip, status: 201
    else
      render json: { errors: clip.errors }, status: 422
    end
  end

  private

    def clip_params
      params.permit(:id, :user_id, :data)
    end
end