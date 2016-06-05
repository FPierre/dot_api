module Api
  module V1
    class RaspberriesController < ApplicationController
      before_action :set_api_v1_raspberry, only: [:show, :update, :destroy]

      # GET /api/v1/raspberries
      def index
        @api_v1_raspberries = Api::V1::Raspberry.all

        render json: @api_v1_raspberries
      end

      # GET /api/v1/raspberries/1
      def show
        render json: @api_v1_raspberry
      end

      # POST /api/v1/raspberries
      def create
        @api_v1_raspberry = Api::V1::Raspberry.new(api_v1_raspberry_params)

        if @api_v1_raspberry.save
          render json: @api_v1_raspberry, status: :created, location: @api_v1_raspberry
        else
          render json: @api_v1_raspberry.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/raspberries/1
      def update
        if @api_v1_raspberry.update(api_v1_raspberry_params)
          render json: @api_v1_raspberry
        else
          render json: @api_v1_raspberry.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/raspberries/1
      def destroy
        @api_v1_raspberry.destroy
      end

      private
        def set_raspberry
          @raspberry = Raspberry.find(params[:id])
        end

        def raspberry_params
          params.fetch(:api_v1_raspberry, {})
        end
    end
  end
end
