module PandaGo
  class Error < StandardError; end

  class ContentTypeNotSupportedError < Error
    def initialize(type_name)
      super("Content-Type not supported for: #{ type_name }")
    end
  end

  class UrlNotSetError < Error
    def initialize
      super("PandaGo url has not been configured")
    end
  end

  class RequestError < Error
    attr_reader :response

    def initialize(response)
      @response = response
      super("#{ response.code } #{ response.message }")
    end
  end

  class TimeoutError < Error
    def initialize
      super("Request took longer than #{ PandaGo.configuration.timeout } seconds")
    end
  end
end
