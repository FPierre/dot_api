module Api
  module V1
    class VoiceCommandsController < ApplicationController
      before_action :authenticate, :authorize

      api :GET, '/voice-commands', 'Get all voice commands for SARAH'
      error code: 200, desc: 'Ok'
      meta clients: [:android_application, :web_application], status: :pending
      example <<-EOS
        {
          "data": [
            { "name": "name command 1", description: "desc command 1" },
            { "name": "name command 2", description: "desc command 2" },
            { "name": "name command 3", description: "desc command 3" },
          ]
        }
      EOS
      def index
        commands = [
          { name: 'name command 1', description: 'desc command 1' },
          { name: 'name command 2', description: 'desc command 2' },
          { name: 'name command 3', description: 'desc command 3' },
        ]

        render json: { data: commands }
      end
    end
  end
end
