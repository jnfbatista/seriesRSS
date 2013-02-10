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

    end

    def to_s
        ret = ""
        ret += "Identifier: " + @id + "\n"
        ret += "Location: " + @url + "\n"
        ret += "Destination: " + @path + "\n"
        ret += "Frequency: " + @frequency.to_s
    end
end
