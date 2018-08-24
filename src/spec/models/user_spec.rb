# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    describe 'login field' do
      subject(:user) { described_class.new(login: login) }

      context 'when null login' do
        let(:login) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when not null login' do
        let(:login) { 'whatever' }

        it { is_expected.to be_valid }
      end

      context 'when exists login' do
        let(:login) { 'whatever' }

        before { user.dup.save! }

        it { is_expected.not_to be_valid }
      end
    end
  end
end
