class Show < ActiveRecord::Base

  has_many :favorites
  has_many :users, through: :favorites

  def populate_shows
    data = Nokogiri::HTML(open("http://www.tv.com/lists/TVcom_editorial:list:2015-tv-schedule-midseason-premiere-dates/widget/premieres/"))

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
end