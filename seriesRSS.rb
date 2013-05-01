#!/usr/bin/env ruby

require 'open-uri'

require_relative 'config_loader/config_loader'

# main function:
# - gets the config (which is included in a 'require')
# - dowloads the torrent 
def main

  # Dummy data
  frequency = 60

  # loads the file to the configuration object
  config_loader = ConfigLoader.new ARGV[0] 

  # Gets the home path
  # @TODO should the paths be relative to the home path? 
  home_path = File.expand_path('~')

  loop do 
    # for each series get the torrents
    config_loader.torrent_list.each do |serie|
      puts "\nDownloading #{serie.id} (last checked on #{serie.last_checked}) "
      serie.get_next_episode do |episode| 

        # gets the filename
        filename = episode.split('/').last
        puts filename

        # Iterate the object list and dowload file
        #open(folder+filename, 'wb') do |file|
        #  file << open(url).read
        #end

      end

      sleep(5)

    end


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
