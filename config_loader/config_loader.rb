require 'yaml'
require 'pathname'
#require 'torrent_item'

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

        @root_path = torrents['rootPath'].to_s.empty? ? "/tmp/" : torrents['rootPath']


        @full_config['torrents'].each_pair do |k,v|
            puts k, "; ",  v
        end
    end


end
