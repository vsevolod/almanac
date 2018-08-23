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
            optional :ip, type: IPAddr
          end
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
      end
    end
  end
end
