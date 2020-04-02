class ApplicationController < ActionController::Base

  before_action :move_to_root_path, except: [:create, :destroy, :update], if: :devise_controller?

  protected

  def move_to_root_path
    redirect_to root_path
  end
end
