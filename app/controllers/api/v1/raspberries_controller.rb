module Api
  module V1
    class RaspberriesController < ApplicationController
      before_action :set_raspberry, only: [:show, :update, :destroy]

      api :GET, '/raspberries', 'Get all Raspberries'
      meta clients: [:sarah, :web_application], status: :ok
      example <<-EOS
        {
          "data": [
            {
              "id": "1",
              "type": "raspberries",
              "attributes": {
                "api_port": 8080,
                "created-at": "2016-06-06T21:42:53.000+02:00",
                "ip-address": "74.235.83.147",
                "mac-address": "24:63:51:7D:1C:02",
                "master_device": false,
                "name": "Raspberry 1"
              }
            }
          ]
        }
      EOS
      def index
        render json: Raspberry.all
      end

      api :GET, '/raspberries/:id', 'Get a Raspberry'
      meta clients: [:sarah, :web_application], status: :ok
      example <<-EOS
        {
          "data": {
            "id": "1",
            "type": "raspberries",
            "attributes": {
              "api_port": 8080,
              "created-at": "2016-06-06T21:42:53.000+02:00",
              "ip-address": "74.235.83.147",
              "mac-address": "24:63:51:7D:1C:02",
              "master_device": false,
              "name": "Raspberry 1"
            }
          }
        }
      EOS
      def show
        render json: @raspberry
      end

      api :POST, '/raspberries', 'Create a Raspberry'
      error code: 201, desc: 'Created'
      error code: 422, desc: 'Unprocessable entity'
      meta clients: [:web_application], status: :ok
      param :api_port,      Integer,       desc: 'API port'
      param :ip_address,    String,        desc: 'IP address',         required: true
      param :mac_address,   String,        desc: 'MAC address',        required: true
      param :master_device, [true, false], desc: 'Control IoT devices'
      param :name,          String,        desc: 'Name',               required: true
      def create
        raspberry = Raspberry.new raspberry_params

        if raspberry.save
          render json: raspberry, status: :created
        else
          render json: raspberry.errors, status: :unprocessable_entity
        end
      end

      api :PUT, '/raspberries/:id', 'Update a Raspberry'
      error code: 201, desc: 'Created'
      error code: 422, desc: 'Unprocessable entity'
      meta clients: [:sarah, :web_application], status: :ok
      param :api_port,      Integer,       desc: 'API port'
      param :ip_address,    String,        desc: 'IP address',         required: true
      param :mac_address,   String,        desc: 'MAC address',        required: true
      param :master_device, [true, false], desc: 'Control IoT devices'
      param :name,          String,        desc: 'Name',               required: true
      def update
        if @raspberry.update raspberry_params
          render json: @raspberry, status: :ok
        else
          render json: @raspberry.errors, status: :unprocessable_entity
        end
      end

      api :DELETE, '/raspberries/:id', 'Delete a Raspberry'
      error code: 204, desc: 'No content'
      error code: 422, desc: 'Unprocessable entity'
      meta clients: [:web_application], status: :ok
      def destroy
        if @raspberry.destroy
          render json: @raspberry, status: :no_content
        else
          render json: @raspberry.errors, status: :unprocessable_entity
        end
      end

      private
        def set_raspberry
          @raspberry = Raspberry.find params[:id]
        end

        def raspberry_params
          params.permit :api_port, :domain_name, :master_device, :ip_address, :mac_address, :name
        end
    end
  end
end
