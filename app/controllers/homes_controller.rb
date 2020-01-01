class HomesController < ApplicationController

  def top
    @plans = Plan.includes(:restaurant).where(active: true).order(status: :asc).page(params[:page])
  end


  def search
    # ユーザーが検索した場所を保持する
    if params[:search].present? && params[:search].strip != ""
      session[:location] = params[:search]
    end

    # 近隣のプラン情報を取得する
    if session[:location] && session[:location] != ""
      @plans_address = Plan.includes(:restaurant).available.near(session[:location], 3, order: 'distance')
      if @plans_address.empty?
        @plans_address = Plan.includes(:restaurant).available.all
      end
    end

    # 検索オブジェクトの生成
    @search = @plans_address.ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a

    # 開催日、締切日が過ぎているプランを検索結果から除外する
    if params[:Plan_date] && !params[:plan_date].empty?

      plan_date = Date.parse(params[:plan_date])

      @arrPlans.each do |plan|

        if plan.plan_date < Date.today || plan_date < plan.deadline
          @arrPlans.delete(plan)
        end
      end
    end
  end

  def search_jenre

    if params[:jenre_id].present?
      session[:jenre_id] = params[:jenre_id].to_i
      @plans_address = Plan.joins(:jenre).available.where("jenres.id = ?", session[:jenre_id])
    else
      session[:area_id] = params[:area_id].to_i
      @plans_address = Plan.joins(:area).available.where("areas.id = ?", session[:area_id])
    end

    if @plans_address.empty?
      @plans_address = Plan.includes(:restaurant).available.all
    end

    @search = @plans_address.includes(:jenre, :restaurant).ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a

  end
end
