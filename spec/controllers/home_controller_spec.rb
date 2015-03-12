require 'spec_helper'
require 'rails_helper'

describe HomeController do

  describe '#index' do
    before do
      get :index
    end

    it 'renders' do
      expect(response).to render_template(:index)
    end
  end
end