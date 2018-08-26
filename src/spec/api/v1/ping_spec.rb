# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Ping do
  describe 'GET /api/v1/ping' do
    it 'answers with pong' do
      get '/api/v1/ping'

      expect(response).to be_successful
      expect(response.body).to eq('"pong"')
    end
  end

  describe '404 error' do
    it 'returns 404' do
      get '/api/v1/not_found'

      expect(response).to be_not_found
    end
  end
end
