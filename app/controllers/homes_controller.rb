class HomesController < ApplicationController
  def top
    @plans = Plan.where(active: true).order(status: :asc)
  end

  def search
    # ユーザーが検索した場所を保持する
    if params[:search].present? && params[:search].strip != ""
      session[:location] = params[:search]
    end

    # 近隣のプラン情報を取得する
    if session[:location] && session[:location] != ""
      @plans_address = Plan.where("status = ? AND active = ?", 1, true).near(session[:location], 3, order: 'distance')
      if @plans_address.empty?
        @plans_address = Plan.where("status = ? AND active = ?", 1, true).all
      end
    end

    # 検索オブジェクトの生成 検索結果を一つずつ表示するために配列にする
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
      session[:jenre_id] = params[:jenre_id]
    end

    if session[:jenre_id].to_i == 2
      # ジャンル 寿司
      @plans_address = Plan.joins(:jenre).where("plans.status = ? AND plans.active = ?", 1, true).where("jenres.id = ?", 2)
    elsif session[:jenre_id].to_i == 6
      # ジャンル 焼肉
      @plans_address = Plan.joins(:jenre).where("plans.status = ? AND plans.active = ?", 1, true).where("jenres.id = ?", 6)
    elsif session[:jenre_id].to_i == 12
      # ジャンル フレンチ
      @plans_address = Plan.joins(:jenre).where("plans.status = ? AND plans.active = ?", 1, true).where("jenres.id = ?", 12)
      # ジャンル イタリアン
    elsif session[:jenre_id].to_i == 13
      @plans_address = Plan.joins(:jenre).where("plans.status = ? AND plans.active = ?", 1, true).where("jenres.id = ?", 13)
    end

    if @plans_address.empty?
      @plans_address = Plan.where("status = ? AND active = ?", 1, true).all
    end

    @search = @plans_address.includes(:jenre).ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a
    p "aaaaaaaaaaaaaaaaaaa"
    p @arrPlans
  end
end
