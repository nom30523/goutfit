# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :set_user, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if @user.valid_password?(sign_in_params[:password])
      super
    else
      flash.now[:alert] = 'メールアドレスまたはパスワードが違います'
      render 'posts/index'
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  def set_user
    @user = User.find_by!(email: sign_in_params[:email])
  rescue
    flash.now[:alert] = 'メールアドレスまたはパスワードが違います'
    render 'posts/index'
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
