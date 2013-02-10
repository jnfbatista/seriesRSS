require 'open-uri'
require 'nokogiri'

class TorrentItem
  attr_accessor :id, :frequency, :url, :path, :last_checked

  def initialize(id, url, path, frequency=0.5)
    @id = id
    @url = url
    @path = path
    @frequency = (frequency.nil?) ? 0.5 : frequency
  end
  #def initialize(h)
  #    h.each {|k,v| send("#{k}=",v)}
  #end
  #

  def get_torrent_url
    response = nil

    while response.nil?
      response = open(self.url)
    end

    xml = Nokogiri::XML(response)

    xml.slop!()
    xml.rss.channel.item.each do |it|
      puts it.link.text
    end
  end

  def to_s
    ret = ""
    ret += "Identifier: " + @id + "\n"
    ret += "Location: " + @url + "\n"
    ret += "Destination: " + @path + "\n"
    ret += "Frequency: " + @frequency.to_s
  end
end
