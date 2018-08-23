module API
  module V1
    module Posts
      class Entity < Grape::Entity
        expose :id
        expose :title
        expose :content
        expose :user_ip, as: :ip
        expose :user, using: Users::Entity
      end
    end
  end
end
