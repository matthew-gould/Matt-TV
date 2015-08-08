class ShowsController < ApplicationController

  def show
    @show = Show.find_by(id: params[:id])
    @favorites = current_user.favorites.pluck(:show_id)
    @info = Show.show_info(@show)
    @season = Show.season_info(@show)
    n = @season.last["season_number"]
    @latest = Show.latest_season(@show, n)
    @pics = Show.get_images(@show)
    @vids = Show.get_videos(@show)
  end

  def index
    @shows = Show.order(name: :asc)
    if current_user
      @favorites = current_user.favorites.pluck(:show_id)
    end
  end

  def search
    @results = Show.search_name(params[:search])
    @search_text = params[:search]
  end
end