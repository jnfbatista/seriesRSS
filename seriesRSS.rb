#!/usr/bin/env ruby

require 'open-uri'

require_relative 'config_loader/config_loader'

# main function:
# - gets the config (which is included in a 'require')
# - dowloads the torrent 
def main

  # Dummy data
  url = "http://torrents.thepiratebay.se/8125081/Star_Wars_The_Clone_Wars_S05E17_Sabotage_HDTV_x264-FQM.8125081.TPB.torrent"
  folder = "/home/batista/"
  frequency = 60

  config_loader = ConfigLoader.new ARGV[0] 

  loop do 
    # for each series get the torrents
    config_loader.torrent_list.each do |serie|
      puts "Downloading #{serie.id}"
      serie.get_torrent_url
    end

    # gets the filename
    filename = url.split('/').last

    # Iterate the object list and dowload file
    open(folder+filename, 'wb') do |file|
      file << open(url).read
    end

    sleep(5)
    # loads the file to the configuration object

  end
end

# prints the usage 
def usage

end

# gets the file and stores it
def get_series

end


# Run da bitch
main
