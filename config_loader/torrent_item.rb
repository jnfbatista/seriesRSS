require 'open-uri'
require 'nokogiri'

class TorrentItem
  attr_accessor :id, :frequency, :url, :path, :last_checked

  def initialize(id, url, path, frequency=0.5, last_checked=nil)
    @id = id
    @url = url
    @path = path
    @frequency = (frequency.nil?) ? 0.5 : frequency
    @last_checked = nil
  end

  def get_next_episode
    response = nil

    # @TODO only checks if Time.now >= @last_checked + @frequency

    tries = 5
    while response.nil? and tries > 0
      begin
        response = open(self.url)
        puts "got response" if response
      rescue
        puts "Error accessing url: #{self.url}, trying again in 5 seconds"
        tries -= 1 
        response = nil
        sleep(5)
      end

    end

    return nil if tries < 1
      
    xml = Nokogiri::XML(response)
    xml.slop!()

    xml.rss.channel.item.each do |it|
      if @last_checked == nil or ( @last_checked and Time.new(it.pubDate.text) > @last_checked )
        yield it.link.text
      end
    end

    update_last_checked
  end

  def update_last_checked
    @last_checked = Time.now
  end

  def to_s
    ret = ""
    ret += "Identifier: " + @id + "\n"
    ret += "Location: " + @url + "\n"
    ret += "Destination: " + @path + "\n"
    ret += "Frequency: " + @frequency.to_s
  end
end
