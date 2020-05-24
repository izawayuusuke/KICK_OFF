module RoomsHelper
  def unchecked_messages
    @messages = []
    current_user.rooms.each do |room|
      @messages += room.messages.where.not(user_id: current_user.id).where(checked: false)
    end
    @messages
  end
end
