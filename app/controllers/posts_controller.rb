class PostsController < ApplicationController

  def index
  end
  
  def new
    @outfits = Outfit.where(user_id: current_user.id)
  end

  def create
  end

end
