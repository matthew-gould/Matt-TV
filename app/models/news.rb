class News
  
  attr_reader :title, :pic, :link

  def initialize(title:, pic:, link:)
    @title, @pic, @link = title, pic, link
  end

  def self.get_news
    news = Nokogiri::HTML(HTTParty.get("http://www.tv.com/news/").body)

    all_news = []
    news.css("._story_capsule").each do |x|
      title = x.css('.title a').first.text.squish
      pic = x.css('._image_container img').first['src']
      link = x.css('.title a').first['href']

      all_news << News.new(title: title, pic: pic, link: link)
    end
    return all_news
  end

  def self.sample_all
    news_array = News.get_news
    rand_news = news_array.shuffle.uniq.first(8)
    return rand_news
  end
end