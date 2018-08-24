module API
  module V1
    module Posts
      class Create < Grape::API
        helpers Posts::Helpers

        namespace :posts do
          # PUT /api/v1/posts
          desc 'Create post',
            named: 'create',
            success: { code: 200, model: Entity, message: 'Post successfully creates' },
            failure: [{ code: 422, message: 'Unprocessable entity' }]
          params { use :create_post }
          put do
            post_params = declared(params)
            post = new_post(post_params)
            post.save!

            present post, with: Entity
          end
        end
      end
    end
  end
end
