# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Users::ByIP do
  subject(:result) { described_class.call }

  let(:user1) { create_user }
  let(:user2) { create_user }
  let(:ip1) { Faker::Internet.ip_v4_address }
  let(:ip2) { Faker::Internet.ip_v4_address }

  context 'with one post' do
    before do
      create_post(user_id: user1.id, user_ip: ip1)
    end

    it { is_expected.to be_empty }
  end

  context 'with two posts with the same ip' do
    before do
      create_post(user_id: user1.id, user_ip: ip1)
      create_post(user_id: user2.id, user_ip: ip1)
    end

    it { expect(result.size).to eq(1) }
  end

  context 'with four posts with two ips' do
    before do
      create_post(user_id: user1.id, user_ip: ip1)
      create_post(user_id: user2.id, user_ip: ip1)
      create_post(user_id: user1.id, user_ip: ip2)
      create_post(user_id: user2.id, user_ip: ip2)
    end

    it { expect(result.size).to eq(2) }
  end
end
