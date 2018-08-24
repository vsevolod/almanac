# frozen_string_literal: true

module API
  module V1
    module Posts
      module Helpers
        extend Grape::API::Helpers

        params :create_post do
          requires :title, type: String
          requires :content, type: String
          optional :user, type: Hash do
            optional :login, type: String
            optional :ip, type: IPAddr, documentation: {
              type: 'string',
              format: 'IPv4, IPv6 address format'
            }
          end
        end

        params :evaluate_post do
          requires :value, type: Integer, values: Mark::E..Mark::A
        end

        def find_post!
          @post = Post.find(params[:post_id])
        end

        def new_post(params)
          user = User.find_or_initialize_by(login: params.dig(:user, :login))

          Post.new(
            user: user,
            title: params[:title],
            content: params[:content],
            user_ip: params.dig(:user, :ip)
          )
        end

        def post_evaluate
          Operations::Posts::Evaluate.new.call(
            post: @post,
            value: params[:value]
          )
        end
      end
    end
  end
end
