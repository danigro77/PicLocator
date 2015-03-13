require "instagram"

class ImagesController < ApplicationController

  def index
    client = Instagram.client(:access_token => session[:access_token])
    @pictures = []
    @images = if session[:next_max_id]
                client.media_search(params[:latitude],params[:longitude], :max_id => session[:next_max_id])
              else
                client.media_search(params[:latitude],params[:longitude])
              end
    session[:next_max_id] = @images.pagination#.try(:next_max_id)
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