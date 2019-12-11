class PlansController < ApplicationController

  before_action  :set_plan, except: [:new, :index, :create]
  before_action  :set_rest, only: [:new, :create, :update, :rest_info]

  def index
  end

  def new
    @plan = current_user.plans.build
  end

  def create
    @plan = current_user.plans.build(plan_params)
    @plan.user_id = current_user.id
    @plan.restaurant_id = @restaurant.id
    if @plan.save
      redirect_to listing_plan_path(@plan), notice: "プランを新規作成しました！"
    else
      flash.now[:alert] = "プランの新規作成に失敗しました"
      render :new
    end
  end

  def listing

  end

  def rest_info

  end

  def photo_upload
    @photos = @plan.photos
  end

  def description

  end

  def time_info

  end


  def update

    new_params = plan_params
    new_params = plan_params.merge(active: true) if is_ready_plan

    if @plan.update(new_params)
      flash[:notice] = "編集内容を保存しました"
    else
      flash[:alert] = "編集内容の保存に失敗しました..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def show
  end


  private

    def set_plan
      @plan = Plan.find(params[:id])
    end

    def set_rest
      @restaurant = Restaurant.where(user_id: current_user.id).order(id: :desc).first
    end

    def plan_params
      params.require(:plan).permit(:title, :summary, :restaurant_id, :price, :member, :start_time, :end_time, :plan_date,
                                   :deadline, :requirement, :jenre_id, :user_id, :area_id, :period_time, :status, :is_holiday, :active)
    end

    def is_ready_plan
      !@plan.active && !@plan.price.blank? && !@plan.member.blank? && !@plan.jenre_id.blank? && !@plan.status.blank? && !@plan.area_id.blank? &&
      !@plan.restaurant.name.blank? && !@plan.restaurant.address.blank? && !@plan.restaurant.line.blank? && !@plan.restaurant.station.blank? &&
      !@plan.restaurant.walk.blank? && !@plan.summary.blank? && !@plan.title.blank? && !@plan.requirement.blank? && !@plan.photos.blank? &&
      !@plan.plan_date.blank? && !@plan.start_time.blank? && !@plan.end_time.blank? && !@plan.deadline.blank?
    end


end