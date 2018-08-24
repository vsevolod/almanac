require 'rails_helper'

RSpec.describe Operations::Posts::Evaluate do
  subject(:result) { described_class.new.call(attributes) }
  let(:post) { create_post }
  let(:attributes) { { post: post, value: Mark::C } }
  let(:value) { result.value! }

  context 'unexpected mark' do
    let(:attributes) { super().merge(value: 10) }

    it { is_expected.to be_failure }
  end

  context 'failure average' do
    before do
      allow(post).to receive(:save).and_return(false)
      allow(Post).to receive(:find_by).and_return(post)
    end

    it { is_expected.to be_failure }
  end

  context 'valid attributes' do
    let(:mark) { Mark::D }
    let(:attributes) { super().merge(value: mark) }

    it { is_expected.to be_success }
    it { expect(value.marks_count).to eq(1) }
    it { expect(value.average_mark).to eq(mark) }

    context 'with marks' do
      let(:marks) { [1, 2, 4, 5] }

      before do
        post.update(
          marks_count: marks.size,
          average_mark: marks.sum.to_f / marks.size
        )
      end

      it 'updates marks average and count' do
        expect(value.average_mark).to eq(2.8)
        expect(value.marks_count).to eq(5)
      end
    end

    context 'multithreads' do
      let(:marks) { [1, 1, 2, 2, 3, 3, 4, 5, 5, 5] }
      subject(:operation) do
        -> (value) do
          described_class.new.call(
            post: Post.find(post.id),
            value: value
          )
        end
      end

      it 'writes and counts all marks' do
        marks.map do |value|
          Thread.new { operation.call(value) }
        end.each(&:join)

        post.reload

        expect(post.marks.count).to eq(marks.size)
        expect(post.marks_count).to eq(marks.size)
        expect(post.average_mark).to eq(marks.sum.to_f / marks.size)
      end
    end
  end
end
