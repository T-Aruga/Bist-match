class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_reservation, only: [:approve, :decline]

  def create
    plan = Plan.find(params[:plan_id])

    if current_user == plan.user || Reservation.exists?(user_id: current_user.id, plan_id: plan.id)
      flash[:alert] = "このプランに参加希望は出せません"
    elsif params[:reservation][:price].to_i < plan.price
      flash[:alert] = "ホストへの支払額が最低金額を満たしていません"
    elsif current_user.stripe_id.blank?
      flash[:alert] = "クレジットカードを登録して下さい"
      return redirect_to payment_method_path
    else
      @reservation = current_user.reservations.build(reservation_params)
      @reservation.plan_id = plan.id
      @reservation.status = 1

      if @reservation.save
        flash[:notice] = "プランに参加希望をしました"
      else
        flash[:alert] = "参加希望が出来ませんでした.."
      end

    end
    redirect_to plan
  end

  def your_reservation
    @plans = current_user.plans.includes(:reservations, :restaurant).page(params[:page]).per(10)
  end

  def your_entry
    @reservations = current_user.reservations.order(plan_date: :asc).page(params[:page]).per(10)
  end

  def approve
    if @reservation.price == 0
      @reservation.update_attribute(status: 2)
      flash[:notice] = "参加手続きが完了しました!"
    else
      # Stripeの決済を行う
      charge(@reservation.plan, @reservation)
    end
    redirect_to your_reservation_path
  end

  def decline
    @reservation.update_attribute(status: 0)
    redirect_to your_reservation_path
  end


  private

  def charge(plan, reservation)
    if !reservation.user.stripe_id.blank?
      customer = Stripe::Customer.retrieve(reservation.user.stripe_id)
      charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => reservation.price,
        :description => "有料プランへの参加",
        :currency => "jpy"
      )

      if charge
        @reservation.update_attribute(status: 2)
        flash[:notice] = "参加手続きが完了しました!"
      else
        @reservation.update_attribute(status: 0)
        flash[:alert] = "この支払い方法は使用出来ませんでした..."
      end
    end
  rescue Stripe::CardError => e
    @reservation.update_attribute(status: 0)
    flash[:alert] = e.message
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

   def reservation_params
     params.require(:reservation).permit(:price)
   end
end
