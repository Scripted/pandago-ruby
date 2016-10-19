require "pandago/version"
require "pandago/configuration"
require "pandago/converter"
require "pandago/errors"

module PandaGo
  class << self
    def configure
      yield configuration if block_given?
    end

    def configuration
      @configuration ||= self::Configuration.new
    end

    def convert(file, from:, to:)
      self::Converter.new(file, from, to, configuration).convert
    end
  end
end
