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
          Failure(mark.errors.messages)
        end
      end

      def update_average_mark(input)
        post = input[:post]

        post.marks_count += 1
        post.average_mark += (input[:value] - post.average_mark) / post.marks_count

        if post.save
          Success(post)
        else
          Failure(post.errors.messages)
        end
      end

      def lock_post(input, &block)
        input[:post].with_lock do
          block.call(Success(input))
        end
      end
    end
  end
end
