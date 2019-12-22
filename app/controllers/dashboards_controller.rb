class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def index
    @plans = current_user.plans
    @favoPlans = current_user.favorites.includes(:plan).all
  end
end
