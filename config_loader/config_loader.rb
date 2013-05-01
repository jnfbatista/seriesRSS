require 'yaml'
require 'pathname'
require 'chronic'
require_relative 'torrent_item'

class ConfigLoader
    attr_accessor :file_path, :full_config, :torrent_list, :root_path

    def initialize(file_path)
        @file_path = File.join(Dir.getwd, file_path)

        # make sure the file exists
        pn = Pathname.new(@file_path)        
        if not pn.exist?
            raise 'The file you gave me does not exist!!!'
        end

        # load the yaml
        load_config()
    end

    def load_config()
        @full_config = YAML::load_file(@file_path)

        if @full_config['torrents'].empty?
            raise 'The config file is incorrectly formed. A "torrents" part must exist!'
        end

        ## get hold of the interesting part
        torrents = @full_config['torrents']
        if torrents.nil? or torrents.empty?
            raise 'Oops, your "torrents" section seems to be empty or malformed!'
        end

        globalFrequency = 0.0
        torrents.each do |torrentConfigKey, torrentConfigValue|

            if torrentConfigKey == "rootPath"
                @root_path = torrentConfigValue.to_s.empty? ? "/tmp/" : torrentConfigValue.strip
                puts "Found root path: #{@root_path}"
                next
            end

            if torrentConfigKey == "frequency"
                globalFrequency = ConfigLoader.seconds_in(torrentConfigValue) || 1600
                puts "Found global frequency: #{globalFrequency}"
                next
            end

            if torrentConfigValue.is_a? Hash # It's the section relative to the torrent

                @torrent_list ||= Array.new
                torrentId = torrentConfigKey
                torrentUrl = torrentConfigValue['url']
                torrentPath = torrentConfigValue['path'] || @root_path
                torrentFreq = ConfigLoader.seconds_in(torrentConfigValue['frequency']) || globalFrequency

                @torrent_list << TorrentItem.new(torrentId, torrentUrl, torrentPath == nil ? nil : torrentPath, torrentFreq == nil ? nil : torrentFreq)
                next
            end


        end

    end



    def self.seconds_in(time)
        if time.nil?
            return nil
        end

        now = Time.now
        Chronic.parse("#{time} from now", :now => now) - now
    end

    def to_s
        ret = "";
        ret += "ConfigLoader Instance:\n"
        ret += "\tfile_path: " + @file_path + "\n"
        ret += "\troot_path: " + @root_path + "\n"
        ret += "\tSeries:" + "\n"

        @torrent_list.each do |item|
            ret += "\t" + item.to_s + "\n"
        end
        return ret

    end

end
