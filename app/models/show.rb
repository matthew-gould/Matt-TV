class Show < ActiveRecord::Base

  has_many :favorites
  has_many :users, through: :favorites

  def populate_shows
    data = Nokogiri::HTML(HTTParty.get("http://www.tv.com/lists/TVcom_editorial:list:2015-tv-schedule-midseason-premiere-dates/widget/premieres/").body)

    # data.css('div.name a').text = "all show names (362 of them)"
    # data.css('.show_info')[0].text.squish = "premiere/air date info for first show in list"
    # data.css('.write-up')[0].text.squish = "summary of show"
    # data.css('.image-wrapper img')[0]['src'] = "link to jpg"

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
      info = HTTParty.get("https://api.themoviedb.org/3/search/tv?api_key=#{Figaro.env.TMD_KEY}&query=#{name}")
      info["results"].each do |y|
        if y["original_name"] == name
          id = info["results"][0]["id"]
          x.update!(db_id: id)
        end
      end
    end
  end

  def self.sample_all
    self.all.shuffle.uniq.first(6)
  end

  def self.get_info(show)
    data = HTTParty.get("https://api.themoviedb.org/3/tv/#{show.db_id}?api_key=611e05c0e68def1ee46e6cb18f643617&append_to_response=images,videos")
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
    # show_info["genres"][0]["name"]
    # show_info["homepage"]
    # show_info["overview"]
    # show_info["last_air_date"]
    # show_info["status"]
    # show_info["poster_path"]
  end

  def self.season_info(show)
    data = self.get_info(show)

    season_info = data["seasons"]
    return season_info

      # season_info["air_date"] = season["air_date"]
      # season_info["poster_path"] = season["poster_path"]
      # season_info["season_number"] = season["season_number"]
      # season_info["episode_count"] = season["episode_count"]
  end

  def self.get_images(show)
    backdrops = []
    data = self.get_info(show)

    # make the backdrops links to the image.tmdb.org/t/p/w1280/8F055jvxGoaFuXiCJfN6ySf9gnB.jpg version of the pic
    
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

    # http://api.themoviedb.org/3/tv/latest
    # http://api.themoviedb.org/3/tv/on_the_air
    # http://api.themoviedb.org/3/tv/airing_today

  def anchor_links
    names = []
    last_x = nil
    shows = Show.all
    shows.each do |x|
      names << x.name
      names = names.sort

      names.each do |x|
        if x[0] != last_x
          true
          last_x = x[0]
        end 
      end
    end
  end
end