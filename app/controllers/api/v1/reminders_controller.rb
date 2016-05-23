module Api
  module V1
    class RemindersController < ApplicationController
      # before_action :authenticate, :authorize

      before_action :set_reminder, only: [:show, :destroy]

      api :GET, '/reminders', 'Get all Reminders'
      meta clients: [:android_application, :web_application], status: :pending
      def index
        render json: Reminder.all
      end

      api :GET, '/reminders', 'Get a Reminder'
      example <<-EOS
        {
          "data": {
            "id": "1",
            "type": "reminders",
            "attributes": {
              "content": "content",
              "created-at": "2016-05-01T15:46:42.000Z",
              "display-at": null,
              "duration": 1,
              "priority": 2,
              "title": null,
              "type": "memo",
              "user": "Pierre Flauder"
            }
          }
        }
      EOS
      meta clients: [:android_application, :web_application], status: :pending
      def show
        render json: @reminder
      end

      api :POST, '/reminders', 'Create a Reminder'
      description "Create a Reminder and display it immediatly on internal screen if no datetime is given"
      error code: 201, desc: 'Created'
      error code: 422, desc: 'Unprocessable entity'
      meta clients: [:android_application, :web_application], status: :pending
      param :content,    String,    desc: 'Content',          required: true
      param :display_at, DateTime,  desc: 'Trigger datetime', required: true
      param :duration,   [1..60],   desc: 'Duration',         required: true
      param :priority,   [1, 2, 3], desc: 'Priority',         required: false
      param :title,      String,    desc: 'Title',            required: false
      param :user_id,    Integer,   desc: 'User ID',          required: true
      def create
        reminder = Reminder.new reminder_params

        if reminder.save
          render json: reminder, status: :created
        else
          render json: reminder.errors, status: :unprocessable_entity
        end
      end

      api :DELETE, '/reminders/:id', 'Delete a Reminder'
      error code: 204, desc: 'No Content'
      meta clients: [:android_application, :web_application], status: :pending
      def destroy
        @reminder.destroy
      end

      private
        def set_reminder
          @reminder = Reminder.find params[:id]
        end

        def reminder_params
          params.permit :content, :display_at, :duration, :priority, :title, :user_id
        end
    end
  end
end
