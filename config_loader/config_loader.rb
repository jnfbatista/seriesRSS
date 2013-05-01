require 'yaml'
require 'pathname'
require 'chronic'
require 'pathname'
require_relative 'torrent_item'

class ConfigLoader
    attr_accessor :file_path, :full_config, :torrent_list, :root_path, :min_check_time, :current_wd

    def initialize(file_path)
        @current_wd = Dir.getwd
        @file_path = File.join(@current_wd, file_path)

        # make sure the file exists
        pn = Pathname.new(@file_path)        
        if not pn.exist?
            raise 'The file you gave me does not exist!!!'
        end

        # load the yaml
        @min_check_time = 9999999
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
                @root_path = File.absolute_path(torrentConfigValue.to_s.strip || @current_wd) 
                next
            end

            if torrentConfigKey == "frequency"
                globalFrequency = ConfigLoader.seconds_in(torrentConfigValue) || 1600
                next
            end

            if torrentConfigValue.is_a? Hash # It's the section relative to the torrent

                @torrent_list ||= Array.new
                torrentId = torrentConfigKey
                torrentUrl = torrentConfigValue['url']
                torrentPath = get_target_path_for_torrent(torrentConfigValue['path'])

                torrentFreq = ConfigLoader.seconds_in(torrentConfigValue['frequency']) || globalFrequency

                @torrent_list << TorrentItem.new(torrentId, torrentUrl, torrentPath, torrentFreq)
                @min_check_time = torrentFreq if torrentFreq < @min_check_time
                next
            end


        end

    end

    #
    #
    def get_target_path_for_torrent(override_path = nil)
        return @root_path if override_path.nil? or override_path.empty?

        if (Pathname.new override_path).absolute?
            return override_path
        else
            return File.join(@root_path, override_path)
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
