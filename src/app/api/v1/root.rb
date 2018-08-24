module API
  module V1
    class Root < Grape::API
      include API::V1::Helpers::ErrorHandler

      prefix :api
      version 'v1', using: :path

      format :json

      mount Ping
      mount Posts::Create
      mount Posts::Evaluate

      add_swagger_documentation(
        add_version: true,
        doc_version: '0.0.1',
        hide_documentation_path: true,
        info: {
          title: 'Almanac API V1'
        }
      )

      route :any, '*path' do
        raise Errors::NotFound, "No such route '#{request.path}'"
      end
    end
  end
end
