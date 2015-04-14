class Show < ActiveRecord::Base

  has_many :favorites
  has_many :users, through: :favorites

  include PgSearch
  pg_search_scope(:search_name,
    :against => { 
      :name => 'A', 
      :actors => 'B', 
      :station => 'C', 
      :summary => 'D'
      },
    :using => [:tsearch, :dmetaphone, :trigram])
    

  def populate_shows #refactor this with an each ["item-box"]
    data = Nokogiri::HTML(HTTParty.get("http://www.tv.com/lists/TVcom_editorial:list:2015-tv-schedule-midseason-premiere-dates/widget/premieres/").body)

    181.times do |x|
      show_name = data.css('div.name a')[x].text
      show_info = data.css('.show_info')[x].text.squish 
      info = show_info.split(" ")
      date = info[0] + " " + info[1] + " " + "2015"
      day = Date.parse(date).strftime("%A")
      time = info[3] + " " + info[4]
      if info.count == 7
        station = info[6]
      else
        n = info.count
          if n == 8
        station = info[6] + " " + info[7]
          elsif n == 9
            station = info[6] + " " + info[7] + " " + info[8]
          elsif n == 10
            station = info[6] + " " + info[7] + " " + info[8] + " " + info[9]
          end
        end
      show_summary = data.css('.write-up')[x].text.squish
      show_pic = data.css('.image-wrapper img')[x]['src']

      Show.create!(name: show_name, premiere: show_info, day: day, time: time, station: station, summary: show_summary, pic_url: show_pic)
    end
  end

  def self.get_id
    show = Show.all
    show.each do |x|
      name = x.name
      info = HTTParty.get("https://api.themoviedb.org/3/search/tv?api_key=#{Figaro.env.tmd_key}&query=#{name}")
      info["results"].each do |y|
        if y["original_name"] == name
          id = info["results"][0]["id"]
          x.update!(db_id: id)
        end
      end
    end
  end

  def self.get_actors
    show = Show.all
    show.each do |x|
      show_id = x.db_id
      info = HTTParty.get("https://api.themoviedb.org/3/tv/#{show_id}/credits?api_key=#{Figaro.env.tmd_key}")
      info["cast"].map {|actor| {"character" => actor["character"], "actor" => actor["name"]}}
      x.update!(actors: actors)
    end
  end

  def self.get_summary
    show = Show.all
    show.each do |x|
      if x.summary == ""
        show_id = x.db_id
        info = HTTParty.get("https://api.themoviedb.org/3/tv/#{x.db_id}?api_key=#{Figaro.env.tmd_key}")
        summary = info["overview"].squish
        x.update!(summary: summary)
      end
    end
  end

  def self.sample_all
    self.all.shuffle.uniq.first(6)
  end

  def self.get_info(show)
    data = HTTParty.get("https://api.themoviedb.org/3/tv/#{show.db_id}?api_key=#{Figaro.env.tmd_key}&append_to_response=images,videos")
    return data
  end

  def self.show_info(show)
    data = self.get_info(show)
    show_info = {}
    
    show_info["genres"] = data["genres"]
    show_info["homepage"] = data["homepage"]
    show_info["overview"] = data["overview"].squish
    show_info["last_air_date"] = data["last_air_date"]
    show_info["status"] = data["status"]
    show_info["poster_path"] = data["poster_path"]

    return show_info
  end

  def self.season_info(show)
    data = self.get_info(show)

    season_info = data["seasons"]
    return season_info
  end

  def self.get_images(show)
    backdrops = []
    data = self.get_info(show)

    data["images"]["backdrops"].each do |x|
      backdrops << x["file_path"]
    end
    return backdrops.shuffle.uniq.first(9)
  end

  def self.get_videos(show)
    videos = []
    data = self.get_info(show)

    data["videos"]["results"].each do |x|
      videos << x["key"]
    end
    return videos
  end

  def self.latest_season(show, season_number)
    season_info = {}
    data = HTTParty.get("http://api.themoviedb.org/3/tv/#{show.db_id}/season/#{season_number}?api_key=#{Figaro.env.tmd_key}")

    season_info = data["episodes"].map {|episode| {"episode_number" => episode["episode_number"], "name" => episode["name"], "air_date" => episode["air_date"]}}
    return season_info
  end
end