require 'spec_helper'
require 'rails_helper'

describe ImagesController do

  describe '#index' do
    before do
      #TODO make stubbing work
      @params = {latitude: '37.775000', longitude: '-122.4183333', radius: '100'}
      @pictures = [ Picture.new("http://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/e15/11056026_326439760900151_446078073_n.jpg", 1),
                    Picture.new("http://scontent.cdninstagram.com/hphotos-xfa1/t51.2885-15/e15/11005226_775886412479388_1586709323_n.jpg", 0.3)
                  ]
      @instagram = double("Instagram")
      @instagram.stub!(:client).and_return(true)
      @client = double("Instagram::Client")
      @client.stub!(:media_search).and_return(@pictures)
      get :index, @params
    end

    xit 'should render a json' do
      expect(response).to render_json(:index)
    end

  end

end