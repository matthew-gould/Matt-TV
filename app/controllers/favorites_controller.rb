class FavoritesController < ApplicationController
  helper_method :sort_column, :sort_direction
  
  def index
    @shows = current_user.shows.order(sort_column + " " + sort_direction)
  end

  def create
    current_user.add_favorite(params[:show_id])
    head :ok
  end

  def destroy
    current_user.remove_favorite(params[:show_id])
    head :ok
  end

  private
  
  def sort_column
    Show.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end