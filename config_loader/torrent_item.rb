class TorrentItem
    attr_accessor :frequency, :url, :path, :last_checked
    def initialize(url, path, frequency=0.5)
        @url = url
        @path = path
        @frequency = frequency
    end
end
