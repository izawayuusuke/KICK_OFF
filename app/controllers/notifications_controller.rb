class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications
    # メッセージを見たら確認済みにする
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
