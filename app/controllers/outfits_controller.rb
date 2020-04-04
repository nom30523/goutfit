class OutfitsController < ApplicationController

  before_action :move_to_top

  def index
  end

  private

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end
end
