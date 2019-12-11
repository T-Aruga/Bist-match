class PhotosController < ApplicationController


  def update
    @plan = Plan.find(params[:plan_id])
   if @plan.update(photo_params)
    @photos = @plan.photos
    redirect_back(fallback_location: request.referer, notice: "保存しました")
   else
    flash[:alert] = "保存出来ませんでした..."
    render "plans/photo_upload"
  end


  def destroy

  end

  private

    def photo_params
      params.require(:plan).permit(photos_images: [])
    end

end
