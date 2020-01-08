module ApplicationHelper
  def unread_notifications
    @notifications = Notification.where(user_id: current_user.id)
    if @notifications.empty?
      current_user.unread
    else
      @notifications[0].user.unread
    end
  end

  def is_ready_plan?
    !plan.active && !plan.price.blank? && !plan.member.blank? && !plan.jenre_id.blank? && !plan.status.blank? && !plan.area_id.blank? &&
    !plan.restaurant.name.blank? && !plan.restaurant.address.blank? && !plan.restaurant.line.blank? && !plan.restaurant.station.blank? &&
    !plan.restaurant.walk.blank? && !plan.summary.blank? && !plan.title.blank? && !plan.requirement.blank? && !plan.photos.blank? &&
    !plan.plan_date.blank? && !plan.start_time.blank? && !plan.end_time.blank? && !plan.deadline.blank?
  end

end
