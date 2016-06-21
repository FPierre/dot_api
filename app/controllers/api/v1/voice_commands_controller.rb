module Api
  module V1
    class VoiceCommandsController < ApplicationController
      before_action :authenticate, :authorize

      api :GET, '/voice_commands', 'Get all voice commands for SARAH'
      error code: 200, desc: 'Ok'
      meta clients: [:android_application, :web_application], status: :pending
      example <<-EOS
        {
          "data": [
            {
              name: "Mise en veille",
              description: "SARAH mets toi en veille"
            },
            {
              name: "Demande d'itinéraire",
              description: [
                "SARAH Affiche moi itinéraire de :from à :to",
                "SARAH Affiche moi un itinéraire de :from à :to",
                "SARAH Affiche-moi itinéraire de :from à :to",
                "SARAH Affiche-moi un itinéraire de :from à :to",
                "SARAH Dis moi itinéraire de :from à :to",
                "SARAH Dis moi un itneraire de :from à :to",
                "SARAH Dis-moi itinéraire de :from à :to",
                "SARAH Dis-moi un itinéraire de :from à :to",
                "SARAH Donne moi itinéraire de :from à :to",
                "SARAH Donne moi un itinéraire de :from à :to",
                "SARAH Donne-moi itinéraire de :from à :to",
                "SARAH Donne-moi un itinéraire de :from à :to",
                "SARAH Recherche moi itinéraire de :from à :to",
                "SARAH Recherche moi un itinéraire de :from à :to",
                "SARAH Recherche-moi itinéraire de :from à :to",
                "SARAH Recherche-moi un itinéraire de :from à :to",
                "SARAH Test itinéraire de :from à :to",
                "SARAH Test un itinéraire de:from à :to"
              ]
            }
          ]
        }
      EOS
      def index
        commands = [
          {
            name: "Mise en veille",
            description: "SARAH mets toi en veille"
          },
          {
            name: "Demande d'itinéraire",
            description: [
              "SARAH Affiche moi itinéraire de :from à :to",
              "SARAH Affiche moi un itinéraire de :from à :to",
              "SARAH Affiche-moi itinéraire de :from à :to",
              "SARAH Affiche-moi un itinéraire de :from à :to",
              "SARAH Dis moi itinéraire de :from à :to",
              "SARAH Dis moi un itneraire de :from à :to",
              "SARAH Dis-moi itinéraire de :from à :to",
              "SARAH Dis-moi un itinéraire de :from à :to",
              "SARAH Donne moi itinéraire de :from à :to",
              "SARAH Donne moi un itinéraire de :from à :to",
              "SARAH Donne-moi itinéraire de :from à :to",
              "SARAH Donne-moi un itinéraire de :from à :to",
              "SARAH Recherche moi itinéraire de :from à :to",
              "SARAH Recherche moi un itinéraire de :from à :to",
              "SARAH Recherche-moi itinéraire de :from à :to",
              "SARAH Recherche-moi un itinéraire de :from à :to",
              "SARAH Test itinéraire de :from à :to",
              "SARAH Test un itinéraire de:from à :to"
            ]
          }
        ]

        render json: { data: commands }
      end
    end
  end
end
