module API
  module V1
    class Ping < Grape::API
      # GET /api/v1/ping
      desc 'Ping',
        named: 'ping',
        success: { code: 200, message: 'Health check' }
      get :ping do
        { ping: 'pong' }
      end
    end
  end
end

