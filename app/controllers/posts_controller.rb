class PostsController < ApplicationController

  before_action :move_to_top, except: [:index]
  before_action :set_outfits
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_outfit_user_id, only: [:create, :update]


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
    if @outfit_user_id == current_user.id
      if @post.save
        redirect_to root_path
      else
        flash_message('画像･日付が選択されていないか、既に登録のある日付です')
        render :new
      end
    else
      flash_message('該当画像が見つかりません')
      render :new
    end
  end
  
  def edit
    redirect_to root_path unless @post.user_id == current_user.id
  end
  
  def update
    if @post.user_id == current_user.id && @outfit_user_id == current_user.id
      if @post.update(post_params)
        redirect_to root_path
      else
        flash_message('画像･日付が選択されていないか、既に登録のある日付です')
        render :edit
      end
    elsif @outfit_user_id != current_user.id
      flash_message('該当画像が見つかりません')
      render :edit
    else
      redirect_to root_path
    end
  end

  def destroy
    @post.destroy if @post.user_id == current_user.id
    redirect_to root_path
  end
  
  
  private
  
  def set_outfits
    @outfits = current_user.outfits.order('created_at DESC') if user_signed_in?
  end

  def set_outfit_user_id
    @outfit_user_id = Outfit.find(post_params[:outfit_id]).user_id
  rescue
    redirect_to root_path
  end
  
  def set_post
    begin
      @post = Post.find(params[:id])
    rescue
      redirect_to root_path
    end
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
