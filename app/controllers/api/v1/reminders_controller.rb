module Api
  module V1
    class RemindersController < ApplicationController
      # before_action :authenticate, :authorize

      before_action :set_reminder, only: [:show, :destroy]

      api :GET, '/reminders', 'Get all Reminders'
      meta clients: [:android_application, :web_application], status: :pending
      example <<-EOS
        {
          "data": [
            {
              "id": "1",
              "type": "reminders",
              "attributes": {
                "content": "content",
                "created-at": "2016-05-01T15:50:41.000Z",
                "display-at": null,
                "duration": 1,
                "priority": 1,
                "title": null,
                "type": "memo",
                "user": "Pierre Flauder"
                "displayed": false,
                "displayed-ago": "environ 9 heures"
              }
            }
          ],
          "links": {
            "self": "http://localhost:4000/api/v1/reminders?page%5Bnumber%5D=2&page%5Bsize%5D=2",
            "first": "http://localhost:4000/api/v1/reminders?page%5Bnumber%5D=1&page%5Bsize%5D=2",
            "prev": "http://localhost:4000/api/v1/reminders?page%5Bnumber%5D=1&page%5Bsize%5D=2",
            "next": "http://localhost:4000/api/v1/reminders?page%5Bnumber%5D=3&page%5Bsize%5D=2",
            "last": "http://localhost:4000/api/v1/reminders?page%5Bnumber%5D=3&page%5Bsize%5D=2"
          }
        }
      EOS
      def index
        render json: Reminder.order(created_at: :desc).page(1)
      end

      api :GET, '/reminders/:id', 'Get a Reminder'
      meta clients: [:android_application, :web_application], status: :pending
      example <<-EOS
        {
          "data": {
            "id": "9",
            "type": "reminders",
            "attributes": {
              "content": "test2",
              "created-at": "2016-05-28T15:58:06.000Z",
              "displayed-at": "2016-05-29T00:00:00.000Z",
              "duration": 10,
              "priority": 1,
              "title": "test2",
              "type": "alert",
              "user": "Pierre Flauder",
              "displayed": false,
              "displayed-ago": "environ 9 heures"
            }
          }
        }
      EOS
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
