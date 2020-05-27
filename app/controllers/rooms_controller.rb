class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
    @others = []
    @rooms.each do |room|
      @others += Entry.where(room_id: room.id).exclude(current_user.id)
    end
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages.limited
      @entries = @room.entries
      @other = @room.entries.exclude(current_user.id).first

      # メッセージを見たら確認済みにする
      @messages.each do |message|
        message.update_attributes(checked: true)
      end
    else
      redirect_back(fallback_location: root_path)
    end
  end



  def create
    if user_signed_in?
      @room = Room.create
      @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
      @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
      redirect_to room_path(@room.id)
    else
      redirect_to new_user_session_path
    end
  end
end
