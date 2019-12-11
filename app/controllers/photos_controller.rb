class PhotosController < ApplicationController


  def update
    @plan = Plan.find(params[:plan_id])
   if @plan.update(photo_params)
    @photos = @plan.photos
    redirect_back(fallback_location: request.referer, notice: "保存しました")
   else
    @photos = @plan.photos
    flash[:alert] = "保存出来ませんでした..."
    render "plans/photo_upload"
   end
  end


  def destroy
    @photo = Photo.find(params[:id])
    @plan = @photo.plan

    @photo.destroy
    @photos = Photo.where(plan_id: @plan.id)

    respond_to :js
  end

  private

    def photo_params
      params.require(:plan).permit(photos_images: [])
    end

end
