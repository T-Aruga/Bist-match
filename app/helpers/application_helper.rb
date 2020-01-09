module ApplicationHelper
  def unread_notifications
    @notifications = Notification.where(user_id: current_user.id)
    if @notifications.empty?
      current_user.unread
    else
      @notifications[0].user.unread
    end
  end

end
