class ReservationsController < ApplicationController


  def create
    plan = Plan.find(params[:id])

    if current_user == plan.user
      flash[:alert] = "自分がホストのプランに参加希望は出せません"
    elsif params[:reservation][:price] < plan.price
      flash[:alert] = "ホストへの支払額が最低金額を満たしていません"
    else
      @reservation = current_user.reservations.build(reservation_params)
      @reservation = plan.id
      @reservation.save

      flash[:notice] = "プランに参加希望をしました"
    end
    redirect_to plan
  end


  private

   def reservation_params
     params.require(:reservation).permit(:price)
   end
end
