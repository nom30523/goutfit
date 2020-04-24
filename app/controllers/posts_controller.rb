class PostsController < ApplicationController
  before_action :move_to_top, except: [:index, :download]
  before_action :set_outfits, except: [:index, :destroy, :download]
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :current_user_only, only: [:edit, :update, :destroy]

  def index
    @posts = current_user.posts.includes(:outfit) if user_signed_in?
    @today = Date.current.strftime('%Y/%m/%d (%a)')
    today = Date.current.strftime('%Y-%m-%d')
    @post = current_user.posts.find_by(appointed_day: today) if user_signed_in?
    @outfit = @post.outfit if @post.present?
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if check_current_user_outfit
      return redirect_to root_path if @post.save

      flash_message('画像･日付が選択されていないか、既に登録のある日付です')
    else
      flash_message('該当画像が見つかりません')
    end
    render :new
  end

  def edit; end

  def update
    if check_current_user_outfit
      return redirect_to root_path if @post.update(post_params)

      flash_message('画像･日付が選択されていないか、既に登録のある日付です')
    else
      flash_message('該当画像が見つかりません')
    end
    render :edit
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def download
    download_file_name = "public/test_img.jpg"
    send_file download_file_name
  end

  private

  def set_outfits
    @outfits = current_user.outfits.order('created_at DESC') if user_signed_in?
  end

  def set_post
    @post = Post.find(params[:id])
  rescue
    redirect_to root_path
  end

  def current_user_only
    post = Post.find(params[:id])
    return redirect_to root_path unless post.user_id == current_user.id
  end

  def check_current_user_outfit
    outfit_user_id = Outfit.find(post_params[:outfit_id]).user_id
    outfit_user_id == current_user.id
  end

  def post_params
    params.require(:post).permit(:outfit_id, :appointed_day).merge(user_id: current_user.id)
  end

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def flash_message(text)
    flash.now[:alert] = "登録に失敗しました(#{text})"
  end
end
