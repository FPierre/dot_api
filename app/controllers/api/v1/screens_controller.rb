module Api
  module V1
    class ScreensController < ApplicationController
      before_action :authenticate, only: :resize
      before_action :authorize, only: :resize

      api :GET, '/screens/path/from/:from/to/:to', 'Display the path between two cities'
      description 'Make a request to the Google Map API to search the car route between the city "from" and the city "to".'
      error code: 400, desc: 'Bad request'
      error code: 200, desc: 'Ok'
      param :from, String, desc: 'Departure city', required: true
      param :to,   String, desc: 'Arrival city',   required: true
      def path
        if params[:from].blank? || params[:to].blank?
          render json: { message: "Absence du paramètre from ou to" }, status: :bad_request and return
        end

        request_from = Geocoder.search params[:from]
        request_to = Geocoder.search params[:to]

        if request_from.blank? || request_to.blank?
          render json: { message: "Erreur lors de la recherche de l'itinéraire" }, status: :bad_request and return
        end

        # OPTIMIZE Idiom pour gérer le code suivant plus proprement

        from = request_from&.first&.data['geometry']['location']
        to = request_to&.first&.data['geometry']['location']

        if from.kind_of? Array
          from = { lat: from[0].dig('lat'), lon: from[0].dig('lng') }
        else
          from = { lat: from.dig('lat'), lon: from.dig('lng') }
        end

        if to.kind_of? Array
          to = { lat: to[0].dig('lat'), lon: to[0].dig('lng') }
        else
          to = { lat: to.dig('lat'), lon: to.dig('lng') }
        end

        # Send to Websocket client lat/lon from 'from' and 'to'
        ActionCable.server.broadcast 'path_channel', path: { from: from, to: to }

        head :ok
      end

      api :GET, '/screens/resize/zone/:zone/size/:size', 'Resize a zone'
      param :zone, [:one, :two],   desc: 'Zone ID', required: true
      param :size, [:full, :half], desc: 'Size',    required: true
      meta access: [:approved, :admin]
      def resize
        if params[:zone].present? && params[:size].present?
          ActionCable.server.broadcast 'resize_channel', zone: params[:zone], size: params[:size]
        end
      end

      # TODO Encore utilisée ?
      # api :GET, '/screens/team', 'Screen to team mode'
      # def team
      #   ActionCable.server.broadcast 'screen_mode_channel', mode: :team
      # end

      # TODO Encore utilisée ?
      # api :GET, '/screens/guest', 'Screen to guest mode'
      # def guest
      #   ActionCable.server.broadcast 'screen_mode_channel', mode: :guest
      # end
    end
  end
end
