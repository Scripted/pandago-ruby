require "pandago/version"
require "uri"

module Pandago
  @@url = nil

  class << self
    def url
      @@url
    end

    def url=(url)
      @@url = URI(url)
      self.url
    end
  end
end
