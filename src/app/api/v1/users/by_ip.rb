# frozen_string_literal: true

module API
  module V1
    module Users
      class ByIP < Grape::API
        namespace :users do
          # GET /api/v1/users/by_ip
          desc 'List of users with the same ips',
               named: 'index',
               success: { code: 200, model: IPWithUsersEntity, message: 'Prepare list of users' }
          get :by_ip do
            ip_list = Operations::Users::ByIP.call

            present ip_list, with: IPWithUsersEntity
          end
        end
      end
    end
  end
end
