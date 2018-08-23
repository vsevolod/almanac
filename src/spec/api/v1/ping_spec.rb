require 'rails_helper'

RSpec.describe 'Test ping/pong request' do
  context 'GET /api/v1/ping' do
    it 'answers with pong' do
      get '/api/v1/ping'

      expect(response).to be_success
      expect(response.body).to eq('"pong"')
    end
  end
end
