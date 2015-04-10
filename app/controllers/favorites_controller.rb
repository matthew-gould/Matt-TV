class FavoritesController < ApplicationController
 
  def index
    @shows = current_user.shows.order(name: :asc)
  end

  def create
    current_user.add_favorite(params[:show_id])
    head :ok
  end

  def destroy
    current_user.remove_favorite(params[:show_id])
    head :ok
  end
end