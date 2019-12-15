class HomesController < ApplicationController
  def top
    @plans = Plan.where(active: true).order(status: :asc)
  end

  def search

  end
end
