require "instagram"

class ImagesController < ApplicationController

  def get_images
    client = Instagram.client(:access_token => session[:access_token])
    radius = (params[:radius].to_i*1000).to_s
    @images = client.location_search(params[:latitude],params[:longitude],radius)
    respond_with @images
  end

end