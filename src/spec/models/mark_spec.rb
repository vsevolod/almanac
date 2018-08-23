require 'rails_helper'

RSpec.describe Mark do
  describe 'validations' do
    context 'value' do
      subject(:mark) { described_class.new(value: mark_value, post: Post.new) }

      context 'big mark' do
        let(:mark_value) { 10 }
        it { is_expected.not_to be_valid }
      end

      context 'null mark' do
        let(:mark_value) { nil }
        it { is_expected.not_to be_valid }
      end

      context 'small mark' do
        let(:mark_value) { 0 }
        it { is_expected.not_to be_valid }
      end

      context 'normal mark' do
        let(:mark_value) { Mark::B }
        it { is_expected.to be_valid }
      end
    end
  end
end
