class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @plan = Plan.find(params[:plan_id])
    unless @plan.good?(current_user)
      @plan.good(current_user)
      # アイコンの切り替え時に必要
      @plan.reload

      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
  end

  def destroy
    @plan = Plan.find(params[:plan_id])
    if @plan.good?(current_user)
      @plan.ungood(current_user)
      # アイコンの切り替え時に必要
      @plan.reload

      respond_to do |format|
        format.html { redirect_to request.referer || root_url }
        format.js
      end
    end
  end
  end
