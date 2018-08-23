require 'rails_helper'

RSpec.describe 'Posts request' do
  context 'PUT /api/v1/posts' do
    let(:params) do
      {
        title: Faker::Lorem.sentence,
        content: Faker::Lorem.paragraph,
        user: {
          login: Faker::Lebowski.actor,
          ip: Faker::Internet.ip_v4_address
        }
      }
    end
    let(:request) { -> { put '/api/v1/posts', params: params } }

    it 'creates new post with author' do
      expect { request.call }
        .to change(Post, :count).by(1)
        .and change(User, :count).by(1)

      json_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(json_response['id']).to be_present
    end

    it 'match json schema' do
      request.call

      expect(response).to match_json_schema('v1/posts/entity')
    end

    context 'without title' do
      before { params[:title] = nil }

      it 'returns error' do
        request.call

        expect(response.status).to eq(422)
      end
    end

    context 'without user attributes' do
      before { params[:user] = nil }

      it 'creates post anyway' do
        request.call

        expect(response).to be_success
      end
    end

    context 'with exists user' do
      before do
        User.create!(login: params.dig(:user, :login))
      end

      it 'skips user create' do
        expect { request.call }.not_to change(User, :count)
      end
    end
  end
end
