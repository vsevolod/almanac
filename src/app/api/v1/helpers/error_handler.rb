module API
  module V1
    module Helpers
      module ErrorHandler
        extend ActiveSupport::Concern

        included do
          rescue_from(
            Errors::NotFound,
            ActiveRecord::RecordNotFound
          ) do |error|
            error!(
              {
                error: 'Not Found',
                message: error.message,
                status: '404'
              },
              404
            )
          end
        end
      end
    end
  end
end
