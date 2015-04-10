class ShowsController < ApplicationController

  def show
  end

  def index
    @shows = Show.order(name: :asc)
    @favorites = current_user.favorites.pluck(:show_id)
  end
end