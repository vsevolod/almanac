# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Ping do
  describe 'GET /api/v1/ping' do
    it 'answers with pong' do
      get '/api/v1/ping'

      expect(response).to be_success
      expect(response.body).to eq('"pong"')
    end
  end
end
