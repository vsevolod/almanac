# frozen_string_literal: true

module Operations
  module Posts
    module Filter
      module_function

      def call(params)
        Post
          .yield_self { |posts| order(posts) }
          .yield_self { |posts| apply_limits(posts, limits_params(params)) }
          .yield_self { |posts| apply_average_filter(posts, average_filter_params(params)) }
      end

      def order(posts)
        posts.includes(:user).order(average_mark: :desc)
      end

      def apply_limits(posts, limit: 10, offset: 0)
        posts.limit(limit).offset(offset)
      end

      def apply_average_filter(posts, average_mark: nil, average_mark_delta: nil)
        return posts if average_mark.blank?
        return posts.where(average_mark: average_mark) if average_mark_delta.blank?

        lower_bound = average_mark - average_mark_delta
        upper_bound = average_mark + average_mark_delta

        posts.where(average_mark: lower_bound..upper_bound)
      end

      def limits_params(params)
        params.slice(:limit, :offset).compact
      end

      def average_filter_params(params)
        params.slice(:average_mark, :average_mark_delta).compact
      end
    end
  end
end
