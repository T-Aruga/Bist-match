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
end
