# frozen_string_literal: true

module API
  module V1
    module Posts
      class Index < Grape::API
        helpers Posts::Helpers

        namespace :posts do
          # GET /api/v1/posts
          desc 'List of posts',
               named: 'index',
               success: { code: 200, model: Entity, message: 'Prepare list of posts' }
          params { use :index_filter }
          get do
            present posts_list, with: Entity
          end
        end
      end
    end
  end
end
