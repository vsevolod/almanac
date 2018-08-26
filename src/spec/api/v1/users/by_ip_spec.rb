# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Users::ByIP do
  describe 'GET /api/v1/users/by_ip' do
    let(:params) { {} }
    let(:request) { -> { get '/api/v1/users/by_ip', params: params } }

    let(:ip1) { Faker::Internet.ip_v4_address }
    let(:ip2) { Faker::Internet.ip_v4_address }

    before do
      user1 = create_user
      user2 = create_user

      create_post(user_id: user1.id, user_ip: ip2)
      create_post(user_id: user1.id, user_ip: ip1)
      create_post(user_id: user2.id, user_ip: ip1)
    end

    it 'returns list of ips with users' do
      request.call

      json_response = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json_response.size).to eq(1)
      expect(json_response.first['ip']).to eq(ip1)
    end
  end
end
