class UsersController < ApplicationController
  before_action :get_user

  def profile
  end

  def description
  end

  def photo_upload
  end

  def favolite_rest
  end

  def show

  end

  def exit
  end

  private

    def get_user
      @user = User.find(params[:id])
    end
end
