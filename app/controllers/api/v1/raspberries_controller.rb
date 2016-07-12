module Api
  module V1
    class RaspberriesController < ApplicationController
      before_action :authenticate, only: :destroy
      before_action :authorize_admin, only: :destroy
      before_action :set_raspberry, only: [:show, :update, :destroy]

      api :GET, '/raspberries', 'Get all Raspberries'
      example <<-EOS
        {
          "data": [
            {
              "id": "1",
              "type": "raspberries",
              "attributes": {
                "api-port": 8080,
                "created-at": "2016-06-06T21:42:53.000+02:00",
                "domain-name": '42.fr',
                "ip-address": "42.42.42.42",
                "mac-address": "42:42:51:7D:1C:02",
                "master-device": false,
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
      example <<-EOS
        {
          "data": {
            "id": "1",
            "type": "raspberries",
            "attributes": {
              "api-port": 8080,
              "created-at": "2016-06-06T21:42:53.000+02:00",
              "domain-name": '42.fr',
              "ip-address": "42.42.42.42",
              "mac-address": "42:42:51:7D:1C:02",
              "master-device": false,
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
      param :api_port,      Integer,       desc: 'API port'
      param :domain_name,   String,        desc: 'API domain name'
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
      param :api_port,      Integer,       desc: 'API port'
      param :domain_name,   String,        desc: 'API domain name'
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
      meta access: [:admin]
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
