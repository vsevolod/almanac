module API
  module V1
    class Root < Grape::API
      version 'v1'

      include API::V1::Helpers::ErrorHandler

      format :json

      mount API::V1::Ping
      #mount API::V1::Swagger

      add_swagger_documentation(
        mount_path: '/swagger.json',
        add_base_path: false,
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
