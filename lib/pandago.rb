require "pandago/version"
require "pandago/converter"
require "pandago/errors"

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

    def convert(file, from:, to:)
      raise UrlNotSetError if url.nil?
      self::Converter.new(file, from, to, url).converted_content
    end
  end
end
