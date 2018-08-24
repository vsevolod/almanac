# frozen_string_literal: true

module Operations
  module Posts
    class Evaluate
      include Dry::Transaction

      around :lock_post

      step :create_mark
      step :update_average_mark

      private

      def create_mark(input)
        mark = input[:post].marks.build(value: input[:value])

        if mark.save
          Success(input)
        else
          Failure(active_record_fail(mark))
        end
      end

      def update_average_mark(input)
        post = input[:post]
        post.apply_mark(input[:value])

        if post.save
          Success(post)
        else
          Failure(active_record_fail(post))
        end
      end

      def lock_post(input)
        input[:post].with_lock do
          yield(Success(input))
        end
      end

      def active_record_fail(record)
        record.errors.messages
      end
    end
  end
end
