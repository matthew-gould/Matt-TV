class FavoritesController < ApplicationController

  def create
    current_user.add_favorite(params[:show_id])
    redirect_to shows_path
  end

  def destroy
    current_user.remove_favorite(params[:show_id])
    redirect_to shows_path
  end
end