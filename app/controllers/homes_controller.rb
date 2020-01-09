class HomesController < ApplicationController

  def top
    @plans = Plan.includes(:restaurant).available.page(params[:page])
  end

  def search
    # ユーザーが検索した場所を保持する
    if params[:search].present? && params[:search].strip != ""
      session[:location] = params[:search]
    end

    # 検索した場所の近隣のプラン情報を取得する
    # 情報が取得できなければ、利用可能なプランを全件取得する
    if session[:location] && session[:location] != ""
      @plans_address = Plan.includes(:restaurant).available.near(session[:location], 2, order: 'distance')
      if @plans_address.empty?
        @plans_address = Plan.includes(:restaurant).available.all
      end
    end

    # 検索オブジェクトの生成
    @search = @plans_address.ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a

    # 検索条件に当てはまらないプランを検索結果から除外する
    # プラン開催日による検索

    if params[:plan_date] && params[:plan_date] != ""
      plan_date = Date.parse(params[:plan_date])
      @arrPlans = @arrPlans.map{|plan| plan if plan.plan_date == plan_date }.compact
    end

    # 時間帯（ランチなど）による検索

    if params[:period_time] && params[:period_time] != ""
      period_time = params[:period_time]
      @arrPlans = @arrPlans.map{|plan| plan if plan.period_time == period_time }.compact
    end
  end

  def search_jenre
    # リンクで渡されたパラメータにより、該当するプラン情報を取得する
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

    # 検索オブジェクトの生成
    @search = @plans_address.includes(:jenre, :restaurant).ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a

    # 検索条件に当てはまらないプランを検索結果から除外する
    # プラン開催日による検索

    if params[:plan_date] && params[:plan_date] != ""
      plan_date = Date.parse(params[:plan_date])
      @arrPlans = @arrPlans.map{|plan| plan if plan.plan_date == plan_date }.compact
    end

  end
end
