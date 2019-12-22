class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = current_user.plans.includes(:restaurant).page(params[:page]).per(6)
    @favoPlans = current_user.favorites.includes(:plan).all
  end
end
