module Api
  module V1
    class DashboardController < ApplicationController
      api :GET, '/dashboard/path/from/:from/to/:to', 'Display the path between two cities'
      description 'Make a request to the Google Map API to search the car route between the city "from" and the city "to".'
      error code: 400, desc: 'Bad request'
      error code: 200, desc: 'Ok'
      meta clients: [:sarah], status: :ok
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

        # TODO Idiom pour gérer le code suivant plus proprement ?

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

        ActionCable.server.broadcast 'path_channel', path: { from: from, to: to }

        head :ok
      end
    end
  end
end
