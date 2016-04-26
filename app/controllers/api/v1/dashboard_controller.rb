module Api
  module V1
    class DashboardController < ApplicationController
      api :GET, '/dashboard/path/from/:from/to/:to', 'Display the path between two cities'
      description 'Request Google API to get the car path between the city "from" and the other city "to"'
      error code: 400, desc: 'Bad request'
      meta clients: [:sarah], status: :pending
      param :from, String, desc: 'Departure city', required: true
      param :to, String, desc: 'Arrival city', required: true
      def path
        if params[:from].blank? || params[:to].blank?
          render json: { status: :bad_request, message: "Absence du paramètre from ou to" } and return
        end

        request_from = Geocoder.search params[:from]
        request_to = Geocoder.search params[:to]

        if request_from.blank? || request_to.blank?
          render json: { status: :bad_request, message: "Erreur lors de la recherche de l'itinéraire" } and return
        end

        from = request_from&.first&.data['geometry']['location'],
        to = request_to&.first&.data['geometry']['location']

        path = {
          from: { lat: from.dig('lat'), lon: from.dig('lon') },
          to: { lat: to.dig('lat'), lon: to.dig('lon') }
        }

        ActionCable.server.broadcast 'path_channel', path: path

        render head :ok and return
      end
    end
  end
end
