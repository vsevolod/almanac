# frozen_string_literal: true

module API
  module V1
    module Users
      class Entity < Grape::Entity
        expose :id
        expose :login
      end
    end
  end
end
