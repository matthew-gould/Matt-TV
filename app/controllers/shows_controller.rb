class ShowsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def show
  end

  def index
    @shows = Show.order(sort_column + " " + sort_direction)
    @favorites = current_user.favorites.pluck(:show_id)
  end

  # private
  
  def sort_column
    Show.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end