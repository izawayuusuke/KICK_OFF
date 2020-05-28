module RoomsHelper
  def unchecked_messages
    @messages = []
    current_user.rooms.each do |room|
      @messages += room.messages.exclude(current_user.id).where(checked: false)
    end
    @messages
  end

  def unchecked_other_message(other)
    @messages = []
    current_user.rooms.each do |room|
      @messages += room.messages.exclude(current_user.id).where(checked: false, user_id: other.user_id)
    end
    @messages
  end
end
