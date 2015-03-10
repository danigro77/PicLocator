require "instagram"

class ImagesController < ApplicationController

  def index
    client = Instagram.client(:access_token => session[:access_token])
    radius = (params[:radius].to_i*1000).to_s
    @images = client.location_search(params[:latitude],params[:longitude],radius)
    render :json => @images
  end

end