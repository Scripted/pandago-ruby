require "uri"

module PandaGo
  class Configuration
    DEFAULT_TIMEOUT = 5

    attr_reader :url
    def url=(url)
      @url = URI(url)
      self.url
    end

    def port
      url&.port
    end

    def host
      url&.host
    end

    def timeout
      @timeout || DEFAULT_TIMEOUT
    end
    attr_writer :timeout
  end
end
