# frozen_string_literal: true

require 'rails_helper'

RSpec.describe API::V1::Posts::Evaluate do
  include Dry::Monads::Result::Mixin

  describe 'POST /api/v1/posts/:post_id/evaluate' do
    let(:exists_post) { create_post }
    let(:params) { { value: Mark::A } }
    let(:request) { post "/api/v1/posts/#{exists_post.id}/evaluate", params: params }

    it 'returns average_mark' do
      request

      json_response = JSON.parse(response.body)
      expect(response).to be_success
      expect(json_response['average_mark']).to eq(params[:value])
    end

    context 'when operation returns failure' do
      let(:failure_result) { Failure('error message') }

      before do
        allow_any_instance_of(Operations::Posts::Evaluate)
          .to receive(:call).and_return(failure_result)
      end

      it 'returns error' do
        request

        json_response = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_response['error']).to eq(failure_result.failure)
      end
    end
  end
end
