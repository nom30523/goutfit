class OutfitsController < ApplicationController
  before_action :move_to_top
  before_action :set_outfits, only: [:index, :create]

  def index
    @outfit = Outfit.new
  end

  def create
    @outfit = Outfit.new(outfit_params)
    if @outfit.save
      redirect_to action: :index
    else
      flash.now[:alert] = '登録に失敗しました(画像を選択してください)'
      render :index
    end
  end

  def destroy
    outfit = Outfit.find(params[:id])
    outfit.destroy if outfit.user_id == current_user.id
    redirect_to action: :index
  rescue
    redirect_to action: :index
  end

  private

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def set_outfits
    @outfits = current_user.outfits.order('created_at DESC').page(params[:page]).per(8)
  end

  def outfit_params
    params.require(:outfit).permit(:image).merge(user_id: current_user.id)
  rescue
    params.permit(:image).merge(user_id: current_user.id)
  end
end
