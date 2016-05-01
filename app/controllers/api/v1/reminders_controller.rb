module Api
  module V1
    class RemindersController < ApplicationController
      # acts_as_token_authentication_handler_for User, fallback: :exception

      api :POST, '/reminders', 'Create a Reminder'
      error code: 422, desc: 'Unprocessable entity'
      error code: 201, desc: 'Created'
      meta clients: [:android_application, :web_application], status: :pending
      param :content,    String,    desc: 'Content',          required: true
      param :display_at, DateTime,  desc: 'Display datetime', required: true
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

      private
        def reminder_params
          params.permit(:content, :priority, :title, :user_id)
        end
    end
  end
end
