class OutfitsController < ApplicationController

  before_action :move_to_top

  def index
    @outfit = Outfit.new
  end

  def create
    @outfit = Outfit.new(outfit_params)
    @outfit.create
    redirect_to action: :index
  end

  private

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def outfit_params
    params.require(:outfit).permit(:image).merge(user_id: current_user.id)
  end

end
