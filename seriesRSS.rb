#!/usr/bin/env ruby

require 'open-uri'
require 'net/http'
require 'fileutils'

require_relative 'config_loader/config_loader'

# main function:
# - gets the config (which is included in a 'require')
# - dowloads the torrent 
def main

  # Dummy data
  frequency = 60

  # loads the file to the configuration object
  config_loader = ConfigLoader.new ARGV[0] 
  sleep_time = config_loader.min_check_time
  puts "Our loop will sleep for #{sleep_time} seconds at each iteration (minimum check time found for the all torrents)"
  # Gets the home path
  # @TODO should the paths be relative to the home path? 
  home_path = File.expand_path('~')

  loop do 
    # for each series get the torrents
    config_loader.torrent_list.each do |serie|
      puts "\nDownloading \"#{serie.id}\" (last checked on #{serie.last_checked}) "
      serie.get_next_episode do |episode| 


        # gets the filename
        filename = episode.split('/').last
        puts filename
        get_serie(serie, episode, filename)

      end

      sleep(sleep_time)

    end


  end
end

# prints the usage 
def usage

end

# gets the file and stores it
# TODO: try for a fixed number of time, in case the torrent download
# fails
def get_serie(serie, url, filename)
  tries = 3
  while tries > 0
    begin
      uri = URI.parse(URI.encode(url, "[]"))
      puts "Trying to download the following torrent:\n#{uri}."
      torrent_content = Net::HTTP.get(uri)
      break
    rescue
      puts "Oops, seems that an error occurred while trying to download the torrent #{url}!\n"
      tries -= 1
      sleep(3)
    end
  end

  return nil if torrent_content.nil?
  puts "Downloaded succeeded! Now saving torrent file on disk."

  if not File.directory?(serie.path)
    FileUtils.mkdir_p serie.path
  end
  new_torrent_file = open(File.join(serie.path, filename), 'wb')
  new_torrent_file << torrent_content
  new_torrent_file.close()

end


# Run da bitch
main
