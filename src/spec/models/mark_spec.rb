# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Mark do
  describe 'validations' do
    describe 'value field' do
      subject(:mark) { described_class.new(value: mark_value, post: Post.new) }

      context 'when the mark is big' do
        let(:mark_value) { 10 }

        it { is_expected.not_to be_valid }
      end

      context 'without mark' do
        let(:mark_value) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when the mark is small' do
        let(:mark_value) { 0 }

        it { is_expected.not_to be_valid }
      end

      context 'when the mark is in range' do
        let(:mark_value) { Mark::B }

        it { is_expected.to be_valid }
      end
    end
  end
end
