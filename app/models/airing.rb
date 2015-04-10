class Airing
  
  attr_reader :network, :show, :day, :time

  def initialize(network:, show:, day:, time:)
    @network, @show, @day, @time = network, show, day, time
  end
  
  def self.all
    result = []
    day = []
    data = Nokogiri::XML(HTTParty.get("http://services.tvrage.com/feeds/fullschedule.php?country=US&24_format=1").body)
    
    day << data.xpath("//DAY")[1]
    times = data.xpath("//time")
    shows = data.xpath("//show")
    network = data.xpath("//network")

    day.each do |day|
      a = day['attr']
      times = day.xpath("./time")
      times.each do |time|
        b = time['attr']
        shows = time.xpath("./show")
        shows.each do |show|
          c = show['name'].downcase
          network = show.xpath("./network")
          network.each do |network|
            d = network.text.downcase
        result << Airing.new(day: a, time: b, show: c, network: d)
          end
        end
      end
    end
    result
  end

  def search(name)
    Airing.all.find { |x| x.show == name }
  end
end

# .find { |x| x.show == "dig" }
# .group_by { |r| r.show }
# .group_by { |r| r.show }.sort_by { |k,v| -v.count }
# .group_by(&:show)

# TW CAble: 61139

# http://api.rovicorp.com/TVlistings/v9/listings/services/postalcode/43065/info?locale=en-US&
# countrycode=US&apikey=7dqhgf2q82uepafse89sq3aa&sig=9400d7d0005f88bbba2a2bf37dc92dad
