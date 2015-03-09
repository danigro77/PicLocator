class HomeController < ApplicationController

  def index
    if Rails.env == 'production'
      redirect_to "https://api.instagram.com/oauth/authorize/?client_id=7d7344e30b264b80a437ab551f0b768c&redirect_uri=https://piclocator.herokuapp.com&response_type=code"
    else
      redirect_to "https://api.instagram.com/oauth/authorize/?client_id=94007f946c06472095ceb9eda05955c5&redirect_uri=http://localhost:3000&response_type=code"
    end
  end
end