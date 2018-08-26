# frozen_string_literal: true

module API
  module V1
    module Users
      class IPWithUsersEntity < Grape::Entity
        expose :ip do |hash|
          hash['user_ip']
        end

        expose :logins do |hash|
          JSON.parse(hash['logins'])
        end
      end
    end
  end
end
