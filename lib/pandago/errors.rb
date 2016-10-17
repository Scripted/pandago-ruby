module Pandago
  class Error < StandardError; end

  class ContentTypeNotSupportedError < Error
    def initialize(type_name)
      super("Content-Type not supported for: #{ type_name }")
    end
  end

  class UrlNotSetError < Error
    def initialize
      super("Pandago.url has not been set")
    end
  end
end
