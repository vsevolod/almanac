# frozen_string_literal: true

module API
  module V1
    module Posts
      class Evaluate < Grape::API
        helpers Posts::Helpers

        namespace :posts do
          route_param :post_id do
            before { find_post! }

            # POST /api/v1/posts/:id/evaluate
            desc 'Evaluates the post',
                 named: 'evaluate_post',
                 success: { code: 200, model: Entity, message: 'Successfully evaluates the post' },
                 failure: [
                   { code: 422, message: 'Unprocessable entity' },
                   { code: 404, message: 'Post not found' }
                 ]
            params { use :evaluate_post }
            post '/evaluate' do
              result = post_evaluate

              if result.success?
                status(200)
                present result.value!, with: Entity
              else
                error!(result.failure, 422)
              end
            end
          end
        end
      end
    end
  end
end
