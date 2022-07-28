# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mains', type: :request do
  describe 'GET main#index' do
    it 'returns http success' do
      get '/'
      expect(response).to have_http_status(:success)
      expect(response).to render_template(:index)
    end
  end
end
