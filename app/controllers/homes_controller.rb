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
      #binding.pry
      @plans_address = Plan.where(active: true).where(status: 1).near(session[:location], 3, order: 'distance')
    else
      @plans_address = Plan.where(active: true).where(status: 1).all
    end

    # 検索オブジェクトの生成
    @search = @plans_address.ransack(params[:q])
    @plans = @search.result

    @arrPlans = @plans.to_a

    # 開催日、締切日が過ぎているプランを除外する


  end
end
