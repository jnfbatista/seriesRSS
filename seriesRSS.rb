#!/bin/env ruby

require 'open-uri'

# main function:
# - gets the config (which is included in a 'require')
# - dowloads the torrent 
def main

  url = "http://torrents.thepiratebay.se/8125081/Star_Wars_The_Clone_Wars_S05E17_Sabotage_HDTV_x264-FQM.8125081.TPB.torrent"
  folder = "/home/batista/"

  f = File.open(file, 'w') 

  loop do 
    #f.puts "your text"
    #f.flush
    #puts "puts puts"
    #
    filename = url.split('/').last
    
    # Iterate the object list and dowload file
    open(folder+filename, 'wb') do |file|
        file << open(url).read
    end

    sleep(5)
    # loads the file to the configuration object

  end
  f.close
end

# prints the usage 
def usage

end

# gets the file and stores it
def get_series

end


# Run da bitch
main
