class RestaurantsController < ApplicationController


  def search_gnabi
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(rest_params)
    if @restaurant.save
      redirect_to root_path, notice: "店舗情報を保存しました！"
    else
      flash.now[:alert] = "店舗情報の保存に失敗しました"
      render search_gnabi_path
    end
  end

  private

  def rest_params
    params.require(:restaurant).permit(:name, :pc_url, :address, :budget, :line, :station, :walk, :latitude, :longitude, :image_url )
  end

end
