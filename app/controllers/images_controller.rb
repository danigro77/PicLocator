require "instagram"

class ImagesController < ApplicationController

  def index
    client = Instagram.client(:access_token => session[:access_token])
    @pictures = []
    @images = client.media_search(params[:latitude],params[:longitude])
    @images.each do |image|
      @pictures << Picture.get_picture(
          image,
          params[:latitude].to_i,
          params[:longitude].to_i,
          params[:radius].to_i
      ) if image.present?
    end
    render :json => @pictures.compact.sort_by(&:distance)
  end

end