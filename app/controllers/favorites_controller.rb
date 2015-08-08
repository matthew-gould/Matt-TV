class FavoritesController < ApplicationController
 
  def index
    if current_user != nil
      @shows = current_user.shows.order(name: :asc)
    end
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