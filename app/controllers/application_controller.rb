class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # プロフィールが公開されていなければ、ユーザ情報入力ページへ
  def after_sign_in_path_for(resource)
    if resource.active == false
      profile_user_path(resource)
    else
      root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[fullname phone_number description])
  end
end
