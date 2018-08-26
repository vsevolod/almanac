# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::Posts::Filter do
  subject(:result) { described_class.call(params) }

  before do
    create_post(average_mark: 2.5)
    create_post(average_mark: 3.0)
    create_post(average_mark: 3.7)
  end

  context 'without params' do
    let(:params) { {} }

    it { expect(result.size).to eq(3) }

    it 'orders by max rate' do
      expect(result.first.average_mark).to eq(3.7)
    end
  end

  context 'with limits' do
    let(:params) { { limit: 2 } }

    it { expect(result.size).to eq(2) }

    context 'with offset' do
      let(:params) { { limit: 2, offset: 2 } }

      it { expect(result.size).to eq(1) }
    end
  end

  context 'with average rating' do
    let(:params) { { average_mark: 3 } }

    it { expect(result.size).to eq(1) }
  end

  context 'with average rating and delta' do
    let(:params) { { average_mark: 3, average_mark_delta: 0.5 } }

    it { expect(result.size).to eq(2) }
  end
end
