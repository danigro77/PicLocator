require "instagram"

class ImagesController < ApplicationController

  def index
    client = Instagram.client(:access_token => session[:access_token])
    radius = (params[:radius].to_i*1000).to_s
    @pictures = []
    @images = client.location_search(params[:latitude],params[:longitude],radius)
    @images.each do |image|
      picture_array = client.location_recent_media(image['id'])
      picture_array.each do |picture|
        @pictures << get_picture(picture,params[:latitude],params[:longitude]) if picture.present?
      end if picture_array.present?
    end
    render :json => @pictures
  end

  private

  def get_picture(image, o_lat, o_lon)
    url = image['images']['standard_resolution']['url']
    lat, lon = image['location']['latitude'], image['location']['longitude']
    Picture.new(url, o_lat, o_lon, lat, lon)
  end
end