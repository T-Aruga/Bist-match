class UsersController < ApplicationController
  before_action :get_user

  def profile
  end

  def description
  end

  def photo_upload
  end

  def favorite_store
  end

  def show
  end

  def update

    new_params = user_params
    new_params = user_params.merge(active: true) if is_ready_user

    if @user.update(new_params)
      flash[:notice] = "編集内容を保存しました"
    else
      flash[:alert] = "編集内容の保存に失敗しました..."
    end
    redirect_back(fallback_location: request.referer)
  end

  def exit
  end

  private

    def get_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:fullname, :email, :phone_number, :description, :image, :sex, :age,
                                   :favorite_store, :job, :jenre_id, :active)
    end

    def is_ready_user
      !@user.active && !@user.fullname.blank? && !@user.email.blank? && !@user.description.blank? && !@user.image_id.blank? && !@user.favorite_store.blank? && !@user.jenre_id.blank?
    end


end
