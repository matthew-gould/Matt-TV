class FavoritesController < ApplicationController

  def index
    @favorites = current_user.shows
  end

  def create
    current_user.add_favorite(params[:show_id])
    # redirect_to shows_path
    head :ok
  end

  def destroy
    current_user.remove_favorite(params[:show_id])
    # redirect_to(:back)
    head :ok
  end
end