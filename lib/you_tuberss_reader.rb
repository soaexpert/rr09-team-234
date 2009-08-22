require 'rubygems'
require 'hpricot'
require 'open-uri'

class YouTubeRSSReader
   
  def self.parse(label, start_index, max_results)
    
    feed_contents = "http://gdata.youtube.com/feeds/api/videos/-/#{label}"
    doc = Hpricot(open(feed_contents))
    puts doc
    items = doc.search("entry")
    items.each do |raw_item|
      puts raw_item
      link = raw_item.%('pheedo:origLink') || raw_item.%('feedburner:origLink') || raw_item.%('link')
      puts link
    end
  end
  
end

YouTubeRSSReader.parse 'yoshima', 1, 5