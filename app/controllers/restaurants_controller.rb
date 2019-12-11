class RestaurantsController < ApplicationController


  def search_gnabi
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(rest_params)
    @restaurant.user_id = current_user.id
    if @restaurant.save
      redirect_to new_plan_path, notice: "店舗情報を保存しました！"
    else
      flash.now[:alert] = "店舗情報の保存に失敗しました"
      render :search_gnabi
    end
  end


  def update
    @restaurant = Restaurant.where(user_id: current_user.id).order(id: :desc).first
    if @restaurant.update(rest_params)
      flash[:notice] = "店舗情報を保存しました"
    else
      flash.now[:alert] = "店舗情報を保存出来ませんでした..."
    end
    redirect_back(fallback_location: request.referer)
  end

  private

  def rest_params
    params.require(:restaurant).permit(:name, :pc_url, :address, :budget, :line, :station, :walk, :latitude, :longitude, :image_url )
  end

end
