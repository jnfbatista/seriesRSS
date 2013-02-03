class TorrentItem
    attr_accessor :frequency, :url, :path, :last_checked
    def initialize(url, path, frequency)
        @url = url
        @path = path
        @frequency = frequency
    end
end
