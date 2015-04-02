require 'open-uri'

class Airing
  
  attr_reader :network, :show, :airs_at

  def initialize(network:, show:, airs_at:)
    @network, @show, @airs_at = network, show, airs_at
  end

  def self.all
    result = []
    data = Nokogiri::XML(open("http://services.tvrage.com/feeds/fullschedule.php?country=US&24_format=1"))
    days = data.xpath("//DAY")
    days.each do |day|
      result << airing_for_day(day)
    end

    result
  end

  def self.airing_for_day(day)
    date = day['attr']
    Airing.new(airs_at: date, network: "Fox", show: "Futurama")
  end

end

# data = Nokogiri::XML(open("http://services.tvrage.com/feeds/fullschedule.php?country=US&24_format=1"))

# data.xpath("//DAY").first['attr'] = date 
# data.xpath("//time").first['attr'] = time show airs
# data.xpath("//show").first['name'] = name of show