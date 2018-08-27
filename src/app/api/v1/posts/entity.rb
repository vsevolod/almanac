# frozen_string_literal: true

module API
  module V1
    module Posts
      class Entity < Grape::Entity
        format_with(:to_s, &:to_s)

        expose :id
        expose :title
        expose :content
        expose :user_ip, as: :ip, format_with: :to_s
        expose :user, using: Users::Entity
        expose :average_mark
      end
    end
  end
end
