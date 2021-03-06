class PlansController < ApplicationController
  before_action  :set_plan, except: %i[new index create]
  before_action  :set_rest, only: %i[new create]
  before_action  :authenticate_user!, except: [:show]
  before_action  :correct_user, only: %i[listing rest_info photo_upload description time_info update]

  def index
    @plans = Plan.includes(:restaurant).where(user_id: current_user.id).order(id: :asc).page(params[:page]).per(10)
  end

  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.add_restinfo(@restaurant)
    if @plan.save
      redirect_to listing_plan_path(@plan), notice: 'プランを新規作成しました！'
    else
      flash.now[:alert] = 'プランの新規作成に失敗しました'
      render :new
    end
  end

  def show
    @photos = @plan.photos
    @guest_reviews = @plan.guest_reviews.page(params[:page]).per(4)
  end

  def rest_info
    @restaurant = Restaurant.find_by(id: @plan.restaurant_id)
  end

  def photo_upload
    @photos = @plan.photos
  end

  def update
    new_params = plan_params
    new_params = plan_params.merge(active: true) if @plan.is_ready_plan?

    if @plan.update(new_params)
      if @plan.active == true
        return redirect_to plan_path(@plan), notice: 'プランを公開しました！'
      end

      flash[:notice] = '編集内容を保存しました！'
    else
      flash[:alert] = '編集内容の保存に失敗しました...'
    end
    redirect_back(fallback_location: request.referer)
  end

  private

  def set_plan
    @plan = Plan.find(params[:id])
  end

  def set_rest
    @restaurant = Restaurant.where(user_id: current_user.id).last
    redirect_to search_gnabi_path, notice: '店舗情報をまず登録してください' if @restaurant.nil?
  end

  # 正しいユーザーか確認する
  def correct_user
    unless current_user.id == @plan.user.id
      redirect_to root_path, alert: '権限がありません..'
      end
  end

  def plan_params
    params.require(:plan).permit(:title, :summary, :restaurant_id, :price, :member, :start_time, :end_time, :plan_date,
                                 :deadline, :requirement, :jenre_id, :user_id, :area_id, :period_time, :status, :is_holiday, :active)
  end
end
