module Api
  module V1
    class RaspberriesController < ApplicationController
      before_action :set_raspberry, only: [:show, :update, :destroy]

      def index
        render json: Raspberry.all
      end

      def show
        render json: @raspberry
      end

      def create
        raspberry = Raspberry.new raspberry_params

        if raspberry.save
          render json: raspberry, status: :created
        else
          render json: raspberry.errors, status: :unprocessable_entity
        end
      end

      def update
        if @raspberry.update raspberry_params
          render json: @raspberry
        else
          render json: @raspberry.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @raspberry.destroy
      end

      private
        def set_raspberry
          @raspberry = Raspberry.find params[:id]
        end

        def raspberry_params
          params.fetch :raspberry, {}
        end
    end
  end
end
