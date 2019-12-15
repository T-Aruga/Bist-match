class ReservationsController < ApplicationController


  def create
    plan = Plan.find(params[:plan_id])

    if current_user == plan.user || Reservation.exists?(user_id: current_user.id, plan_id: plan.id)
      flash[:alert] = "このプランに参加希望は出せません"
    elsif params[:reservation][:price].to_i < plan.price
      flash[:alert] = "ホストへの支払額が最低金額を満たしていません"
    else
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.plan_id = plan.id
      @reservation.status = 1
      @reservation.save

      flash[:notice] = "プランに参加希望をしました"
    end
    redirect_to plan
  end

  def your_reservation
    @plans = current_user.plans
  end

  def your_entry
    @reservations = current_user.reservations.order(plan_date: :asc)
  end


  private

   def reservation_params
     params.require(:reservation).permit(:price)
   end
end
