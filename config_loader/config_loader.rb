require 'yaml'
require 'pathname'
require 'torrent_item'

class ConfigLoader
    attr_accessor :file_path, :full_config

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
        puts @full_config.inspect
    end

end
