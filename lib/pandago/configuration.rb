require "uri"

module PandaGo
  class Configuration
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
  end
end
