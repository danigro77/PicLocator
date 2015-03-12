require 'spec_helper'
require 'rails_helper'

describe Picture do

  describe '#initialize' do
    before do
      @url = 'www.bla.com'
      @dis = 3
      @pic = Picture.new(@url, @dis)
    end
    it 'initializes a new picture object' do
      expect(@pic.url).to eq @url
      expect(@pic.distance).to eq @dis
    end
  end

  describe '.get_picture' do
    before do
      @params = {latitude: 37.775000, longitude: -122.4183333, radius: 100}
      @image_in_radius = {  'location' => {'latitude' => 37.774275261, 'longitude' => -122.426816284},
                            'images' => {'standard_resolution' => {'url' => 'bla1.com'}}
      }
      @image_at_origin = {'location' => {'latitude' => @params[:latitude], 'longitude' => @params[:longitude]},
                          'images' => {'standard_resolution' => {'url' => 'bla2.com'}}
      }
      @image_outside_radius = {'location' => {'latitude' => 0, 'longitude' => 0},
                               'images' => {'standard_resolution' => {'url' => 'bla3.com'}}
      }
    end

    context 'when inside the expected radius' do
      it 'should create a picture object' do
        pic1 = Picture.get_picture(@image_at_origin, @params[:latitude], @params[:longitude], @params[:radius])
        expect(pic1).to be_a Picture
        pic2 = Picture.get_picture(@image_in_radius, @params[:latitude], @params[:longitude], @params[:radius])
        expect(pic2).to be_a Picture
      end
    end

    context 'when outside the expected radius' do
      it 'should not create a picture object' do
        pic = Picture.get_picture(@image_outside_radius, @params[:latitude], @params[:longitude], @params[:radius])
        expect(pic).to_not be_a Picture
        expect(pic).to be_nil
      end
    end
  end

  describe '.find_distance' do
    before do
      @loc1 = [42.990967, -71.463767]
      @loc2 = [42.990967, -71.44365]
      @expected_distance_in_meter = 1636
    end

    it 'should find the distance between two locations' do
      expect(Picture.find_distance(@loc1, @loc2).to_i).to eq @expected_distance_in_meter
    end
  end
end

