class UsersController < ApplicationController
  before_action :set_user, except: [:payment, :add_card, :exit, :destroy]
  before_action :authenticate_user!, except: [:show]
  before_action :forbid_test_user, only: [:update, :destroy]
  before_action :correct_user, only: [:profile, :description, :photo_upload, :favorite_store, :update, :destroy]

  def show
    @plans = @user.plans
    @guest_reviews = Review.where(type: "GuestReview", host_id: @user.id).page(params[:page]).per(4)
    @host_reviews = Review.where(type: "HostReview", guest_id: @user.id).page(params[:page]).per(4)
  end

  def update

    new_params = user_params
    new_params = user_params.merge(active: true) if @user.is_ready_user?

    if @user.update(new_params)
      if @user.active == true
         return redirect_to user_path(@user), notice: "プロフィールを公開しました！"
      end
      flash[:notice] = "編集内容を保存しました！"
    else
      flash[:alert] = "編集内容の保存に失敗しました..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def add_card
    if current_user.stripe_id.blank?
      customer = Stripe::Customer.create(
        email: current_user.email,
        description: "BistMatch 有料プランご利用"
      )
      current_user.stripe_id = customer.id
      current_user.save

      # クレカ情報をStripeに追加する
      customer.sources.create(source: params[:stripeToken])
    else
      customer = Stripe::Customer.retrieve(current_user.stripe_id)
      customer.source = params[:stripeToken]
      customer.save
    end

    flash[:notice] = "カード情報を保存しました！"
    redirect_to payment_method_path
  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to payment_method_path
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: "退会処理が完了しました"
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    # 正しいユーザーか確認する
    def correct_user
      redirect_to root_path, alert: "権限がありません.." unless current_user.id == @user.id
    end

    def user_params
      params.require(:user).permit(:fullname, :email, :phone_number, :description, :image, :sex, :age,
                                   :favorite_store, :job, :jenre_id, :active)
    end

    def forbid_test_user
      if @user.email == "testuser@gmail.com"
        flash[:alert] = "テストユーザーのため変更できません"
        redirect_back(fallback_location: request.referer)
      end
    end

end
