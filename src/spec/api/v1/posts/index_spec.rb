# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Posts::Index do
  describe 'GET /api/v1/posts' do
    let(:params) { {} }
    let(:request) { -> { get '/api/v1/posts', params: params } }

    before do
      create_post(average_mark: 2.5)
      create_post(average_mark: 3.0)
      create_post(average_mark: 3.7)
    end

    it 'returns list of posts' do
      request.call

      json_response = JSON.parse(response.body)
      expect(response).to be_successful
      expect(json_response.size).to eq(3)
    end

    context 'with limit and offset' do
      let(:params) { { limit: 2, offset: 1 } }

      it 'returns two posts' do
        request.call

        json_response = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json_response.size).to eq(2)
      end
    end

    context 'with average mark' do
      let(:params) { { average_mark: 3 } }

      it 'returns one post' do
        request.call

        json_response = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json_response.size).to eq(1)
      end
    end

    context 'with average mark and delta' do
      let(:params) { { average_mark: 3, average_mark_delta: 0.5 } }

      it 'returns one post' do
        request.call

        json_response = JSON.parse(response.body)
        expect(response).to be_successful
        expect(json_response.size).to eq(2)
      end
    end
  end
end
