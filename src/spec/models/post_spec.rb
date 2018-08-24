# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject(:post) do
      described_class.new(
        user: User.new,
        title: title,
        content: content
      )
    end

    let(:title) { Faker::Lorem.sentence }
    let(:content) { Faker::Lorem.paragraph }

    it { is_expected.to be_valid }

    context 'when title blank' do
      let(:title) { '' }

      it { is_expected.not_to be_valid }
    end

    context 'when content blank' do
      let(:content) { '' }

      it { is_expected.not_to be_valid }
    end
  end
end
