class ShowsController < ApplicationController

  def show
  end

  def index
    @shows = Show.all
    @favorites = current_user.favorites.pluck(:show_id)
  end
end