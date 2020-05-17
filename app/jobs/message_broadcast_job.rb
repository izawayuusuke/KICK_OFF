class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message, current_user_id)
    ActionCable.server.broadcast "room_channel_#{message.room_id}", message: render_message(message, current_user_id)
  end

  private
    def render_message(message, current_user_id)

      ApplicationController.renderer.render partial: 'messages/message', locals: { message: message, user_id: current_user_id }
    end
end
