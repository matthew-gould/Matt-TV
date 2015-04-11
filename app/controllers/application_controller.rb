class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]

  def home
    @shows = Show.sample_all
    @news = News.sample_all
  end
end

# http://www.tv.com/news/marvels-daredevil-season-1-review-netflix-142808444492/
