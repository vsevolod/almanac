# frozen_string_literal: true

module API
  module V1
    module Errors
      class NotFound < StandardError; end

      extend ActiveSupport::Concern

      included do
        rescue_from ActiveRecord::RecordInvalid do |error|
          error_response status: 422, message: {
            type: :validation_error,
            errors: error.record.errors.full_messages
          }
        end
      end
    end
  end
end
