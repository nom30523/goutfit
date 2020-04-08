class PostsController < ApplicationController

  before_action :move_to_top, except: [:index]
  before_action :set_outfits

  def index
    @posts = Post.where(user_id: current_user.id).includes(:outfit) if user_signed_in?
  end
  
  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      flash.now[:alert] = '登録に失敗しました(画像･日付が選択されていないか、既に登録のある日付です)'
      render :new
    end
  end

  private

  def set_outfits
    @outfits = Outfit.where(user_id: current_user.id).order('created_at DESC') if user_signed_in?
  end

  def post_params
    params.require(:post).permit(:outfit_id, :appointed_day).merge(user_id: current_user.id)
  end

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

end
