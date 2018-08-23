require 'rails_helper'

RSpec.describe User do
  describe 'validations' do
    context 'login' do
      subject(:user) { described_class.new(login: login) }

      context 'null login' do
        let(:login) { nil }
        it { is_expected.not_to be_valid }
      end

      context 'not null login' do
        let(:login) { 'whatever' }

        it { is_expected.to be_valid }

        context 'exists login' do
          before do
            subject.dup.save!
          end

          it { is_expected.not_to be_valid }
        end
      end
    end
  end
end
