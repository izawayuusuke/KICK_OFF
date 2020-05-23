class RoomsController < ApplicationController
  before_action :authenticate_user!

  def index
    @rooms = current_user.rooms
    @others = [] # メッセージの送信先一覧を格納
    @messages = [] # 相手からの全てのメッセージを格納
    @rooms.each do |room|
      @entry = room.entries.where.not(user_id: current_user.id).first
      @others.push(@entry)

      @messages += room.messages.where(checked: false)
                      .where.not(user_id: current_user.id)
    end

    # メッセージを見たら確認済みにする
    @messages.each do |message|
      message.update_attributes(checked: true)
    end
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @entries = @room.entries
      @other = @room.entries.where.not( user_id: current_user.id ).first
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to room_path(@room.id)
  end
end
