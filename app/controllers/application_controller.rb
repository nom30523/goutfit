class ApplicationController < ActionController::Base

  before_action :move_to_root_path, except: [:create, :destroy, :update], if: :devise_controller?

  # # 例外処理
  # rescue_from ActiveRecord::RecordNotFound, with: :render_404
  # rescue_from ActionController::RoutingError, with: :render_404
  # rescue_from Exception, with: :render_500

  # def render_404
  # render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
  # end

  # def render_500
  # render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
  # end

  protected

  def move_to_root_path
    redirect_to root_path
  end
end
